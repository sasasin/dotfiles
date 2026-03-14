#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "Pillow",
#   "img2pdf",
# ]
# ///

import sys
import tempfile
import zipfile
from pathlib import Path

import img2pdf
from PIL import Image


IMAGE_SUFFIXES = {".jpg", ".jpeg", ".png"}


def images_in_dir(dirpath: Path) -> list[Path]:
    files = [f for f in dirpath.iterdir() if f.is_file() and f.suffix.lower() in IMAGE_SUFFIXES]
    return sorted(files)


def dir_to_pdf(dirpath: Path, output_pdf: Path | None = None) -> None:
    dirpath = dirpath.resolve()
    images = images_in_dir(dirpath)
    if not images:
        return

    if output_pdf is None:
        output_pdf = Path(str(dirpath) + ".pdf")
    output_pdf.unlink(missing_ok=True)
    print(f"converting {dirpath}")

    with tempfile.TemporaryDirectory() as tmpdir:
        paths = []
        for img_path in images:
            img = Image.open(img_path)
            if img.mode == "RGBA":
                rgb = img.convert("RGB")
                tmp = Path(tmpdir) / img_path.name
                rgb.save(tmp, format="PNG")
                paths.append(tmp)
            else:
                paths.append(img_path)

        pdf_bytes = img2pdf.convert([str(p) for p in paths])
        output_pdf.write_bytes(pdf_bytes)


def zip_to_pdf(zippath: Path) -> None:
    zippath = zippath.resolve()
    output_pdf = zippath.with_suffix(".pdf")
    with tempfile.TemporaryDirectory() as tmpdir:
        tmpdir_path = Path(tmpdir)
        with zipfile.ZipFile(zippath) as zf:
            for member in zf.namelist():
                filename = Path(member).name
                if not filename:
                    continue
                (tmpdir_path / filename).write_bytes(zf.read(member))
        dir_to_pdf(tmpdir_path, output_pdf=output_pdf)


def main() -> None:
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <dir|zip> [dir|zip ...]", file=sys.stderr)
        sys.exit(1)

    for arg in sys.argv[1:]:
        path = Path(arg)
        if path.suffix.lower() == ".zip":
            zip_to_pdf(path)
        else:
            root = path
            for dirpath in sorted(root.rglob("*")):
                if dirpath.is_dir():
                    dir_to_pdf(dirpath)
            if root.is_dir():
                dir_to_pdf(root)


if __name__ == "__main__":
    main()

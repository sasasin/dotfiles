#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "Pillow",
# ]
# ///

import sys
import tempfile
import zipfile
from pathlib import Path

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

    pil_images = []
    for img_path in images:
        img = Image.open(img_path)
        if img.mode not in ("RGB", "L"):
            img = img.convert("RGB")
        pil_images.append(img)

    first, *rest = pil_images
    first.save(output_pdf, save_all=True, append_images=rest)


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

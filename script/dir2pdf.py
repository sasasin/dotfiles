#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "Pillow",
# ]
# ///

import sys
from pathlib import Path

from PIL import Image


IMAGE_SUFFIXES = {".jpg", ".jpeg", ".png"}


def images_in_dir(dirpath: Path) -> list[Path]:
    files = [f for f in dirpath.iterdir() if f.is_file() and f.suffix.lower() in IMAGE_SUFFIXES]
    return sorted(files)


def dir_to_pdf(dirpath: Path) -> None:
    dirpath = dirpath.resolve()
    images = images_in_dir(dirpath)
    if not images:
        return

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


def main() -> None:
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <dir> [dir ...]", file=sys.stderr)
        sys.exit(1)

    for arg in sys.argv[1:]:
        root = Path(arg)
        for dirpath in sorted(root.rglob("*")):
            if dirpath.is_dir():
                dir_to_pdf(dirpath)
        if root.is_dir():
            dir_to_pdf(root)


if __name__ == "__main__":
    main()

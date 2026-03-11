#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "PyMuPDF",
# ]
# ///

import shutil
import sys
from pathlib import Path

import fitz  # PyMuPDF


def pdf_to_jpg(pdf_path: Path) -> None:
    dirname = pdf_path.stem
    outdir = pdf_path.parent / dirname
    print(f"converting {pdf_path} to {dirname}")

    if outdir.exists():
        shutil.rmtree(outdir)
    outdir.mkdir()

    doc = fitz.open(pdf_path)
    img_index = 0
    seen_xrefs: set[int] = set()
    for page in doc:
        for img_info in page.get_images():
            xref = img_info[0]
            if xref in seen_xrefs:
                continue
            seen_xrefs.add(xref)
            img_data = doc.extract_image(xref)
            outfile = outdir / f"{dirname}-{img_index:03d}.jpg"
            if img_data["ext"] == "jpeg":
                outfile.write_bytes(img_data["image"])
            else:
                pix = fitz.Pixmap(doc, xref)
                if pix.n > 3:
                    pix = fitz.Pixmap(fitz.csRGB, pix)
                pix.save(str(outfile))
            img_index += 1


def main() -> None:
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <file.pdf> [file.pdf ...]", file=sys.stderr)
        sys.exit(1)

    for arg in sys.argv[1:]:
        pdf_to_jpg(Path(arg))


if __name__ == "__main__":
    main()

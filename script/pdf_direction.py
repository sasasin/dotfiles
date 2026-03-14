#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "pypdf",
# ]
# ///

import argparse
import sys
import tempfile
from pathlib import Path

from pypdf import PdfReader, PdfWriter
from pypdf.generic import NameObject


def get_current_direction(reader: PdfReader) -> str:
    root = reader.trailer.get("/Root")
    if root is None:
        return "/L2R"
    vp = root.get("/ViewerPreferences")
    if vp is None:
        return "/L2R"
    return vp.get("/Direction", "/L2R")


def set_direction(path: Path, new_dir: str) -> None:
    reader = PdfReader(path)
    current = get_current_direction(reader)
    if current == new_dir:
        print(f"{path}: already {new_dir.lstrip('/')}, skipping")
        return

    writer = PdfWriter()
    writer.clone_reader_document_root(reader)
    writer.viewer_preferences.direction = NameObject(new_dir)

    with tempfile.NamedTemporaryFile(delete=False, suffix=".pdf", dir=path.parent) as tmp:
        tmp_path = Path(tmp.name)
        writer.write(tmp)

    tmp_path.replace(path)
    print(f"{path}: {current.lstrip('/')} -> {new_dir.lstrip('/')}")


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Change PDF ViewerPreferences Direction (reading order)"
    )
    group = parser.add_mutually_exclusive_group()
    group.add_argument("--l2r", action="store_true", help="Set direction to L2R (left to right)")
    group.add_argument("--r2l", action="store_true", help="Set direction to R2L (right to left)")
    parser.add_argument("files", nargs="+", metavar="file.pdf")
    args = parser.parse_args()

    for arg in args.files:
        path = Path(arg)
        if not path.exists():
            print(f"{path}: file not found", file=sys.stderr)
            continue

        if args.l2r:
            new_dir = "/L2R"
        elif args.r2l:
            new_dir = "/R2L"
        else:
            reader = PdfReader(path)
            current = get_current_direction(reader)
            new_dir = "/L2R" if current == "/R2L" else "/R2L"

        set_direction(path, new_dir)


if __name__ == "__main__":
    main()

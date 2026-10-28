#!/usr/bin/env python3
import json
import posixpath
import re
from pathlib import Path
from urllib.request import urlopen

MANUAL_ROOT = "docs/user-manual/"
MANUAL_INDEX = MANUAL_ROOT + "user-manual.md"
SITE_ROOT = "/visualization/"
REPOSITORY = "https://github.com/seed-labs/seed-visualization"
RAW_ROOT = "https://raw.githubusercontent.com/seed-labs/seed-visualization/main/"
TREE_URL = "https://api.github.com/repos/seed-labs/seed-visualization/git/trees/main?recursive=1"


def download(url):
    with urlopen(url, timeout=30) as response:
        return response.read().decode("utf-8")


def scan_manuals():
    tree = json.loads(download(TREE_URL))
    return {
        item["path"] for item in tree["tree"]
        if item["type"] == "blob" and item["path"].startswith(MANUAL_ROOT) and item["path"].endswith(".md")
    }


def manual_url(path):
    if path == MANUAL_INDEX:
        return SITE_ROOT
    return SITE_ROOT + path.removeprefix(MANUAL_ROOT).removesuffix(".md").removesuffix("/README") + "/"


def rewrite(markdown, source):
    source_dir = posixpath.dirname(source)
    parts = markdown.split("](")
    for index in range(1, len(parts)):
        path, closing, rest = parts[index].partition(")")
        if not path.endswith((".md", ".png")):
            continue
        target = posixpath.join(source_dir, path)
        target = posixpath.normpath(target)
        if path.endswith(".png"):
            url = RAW_ROOT + target
        else:
            url = manual_url(target)
        parts[index] = url + closing + rest
    return "](".join(parts)


def sync_visualization(root):
    manuals = scan_manuals()

    for source in sorted(manuals):
        markdown = download(RAW_ROOT + source)

        heading = re.search(r"^#[ \t]+(.+?)[ \t]*#*[ \t]*$", markdown, re.M)
        metadata = {
            "layout": "manual", "title": heading[1] if heading else Path(source).stem,
            "nav_key": "visualization", "permalink": manual_url(source),
            "source_path": source, "source_url": f"{REPOSITORY}/blob/main/{source}",
        }
        header = "\n".join(f"{key}: {json.dumps(value, ensure_ascii=False)}" for key, value in metadata.items())

        body = rewrite(markdown, source)

        output = root / "pages" / manual_url(source).strip("/") / "index.md"
        output.parent.mkdir(parents=True, exist_ok=True)
        output.write_text(f"---\n{header}\n---\n\n{body}", encoding="utf-8", newline="\n")
    print(f"Imported {len(manuals)} visualization manuals; images remain on GitHub.")


if __name__ == "__main__":
    sync_visualization(Path(__file__).resolve().parent.parent)

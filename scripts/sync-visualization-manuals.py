#!/usr/bin/env python3
# 扫描 GitHub 手册目录，批量下载 Markdown、修正链接并添加 Jekyll 页头。
# 运行：python scripts/sync-visualization-manuals.py（仅使用标准库）
# 全部使用 Python 标准库，不需要另外安装依赖。
import json  # 解析 GitHub 返回的 JSON，也用于生成合法的 YAML 字符串。
import posixpath  # 处理仓库中使用 / 分隔的路径，不受 Windows 路径格式影响。
import re  # 匹配 Markdown 标题、代码和链接。
from pathlib import Path  # 拼接和创建本地文件路径。
from urllib.request import urlopen  # 通过 HTTP 下载文件。

# 来源与输出地址。扫描整棵仓库文件树，但只导入 MANUAL_ROOT 下的 Markdown。
MANUAL_ROOT = "docs/user-manual/"  # 上游手册目录。
MANUAL_INDEX = MANUAL_ROOT + "user-manual.md"  # 对应网站入口页的文档。
SITE_ROOT = "/visualization/"  # 本网站的手册 URL 前缀，不是磁盘路径。
REPOSITORY = "https://github.com/seed-labs/seed-visualization"  # GitHub 浏览页面。
RAW_ROOT = "https://raw.githubusercontent.com/seed-labs/seed-visualization/main/"  # 文件原文与图片。
# recursive=1 表示同时列出所有子目录中的文件。
TREE_URL = "https://api.github.com/repos/seed-labs/seed-visualization/git/trees/main?recursive=1"


# 下载文本：设置 30 秒网络超时，把返回的字节解码成 UTF-8 字符串。
def download(url):
    with urlopen(url, timeout=30) as response:
        return response.read().decode("utf-8")


# 扫描文件：读取 GitHub 文件清单，筛选手册目录及子目录下的 .md 文件。
def scan_manuals():
    tree = json.loads(download(TREE_URL))
    return {
        item["path"] for item in tree["tree"]
        if item["type"] == "blob" and item["path"].startswith(MANUAL_ROOT) and item["path"].endswith(".md")
    }


# 辅助函数：将上游 Markdown 路径转换为本网站 URL。
# user-manual.md -> /visualization/
# topology/README.md -> /visualization/topology/
# topology/dashboard.md -> /visualization/topology/dashboard/
def manual_url(path):
    if path == MANUAL_INDEX:
        return SITE_ROOT
    return SITE_ROOT + path.removeprefix(MANUAL_ROOT).removesuffix(".md").removesuffix("/README") + "/"


# 手册中的链接都是相对 .md 路径，图片都是相对 .png 路径。
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


# 主流程：扫描文件 -> 下载正文 -> 生成页头 -> 转换链接 -> 写入本地。
def sync_visualization(root):
    # 1. 扫描文件：取得全部手册路径。
    manuals = scan_manuals()

    # 排序后逐篇完成第 2～5 步，每下载一篇就处理并保存一篇。
    for source in sorted(manuals):
        # 2. 下载正文：读取当前这篇 Markdown 的原文。
        markdown = download(RAW_ROOT + source)

        # 3. 生成页头：提取第一个一级标题，没有标题时用不带扩展名的文件名。
        heading = re.search(r"^#[ \t]+(.+?)[ \t]*#*[ \t]*$", markdown, re.M)
        # Jekyll 配置：布局、标题、当前导航项、访问 URL，以及上游来源信息。
        metadata = {
            "layout": "manual", "title": heading[1] if heading else Path(source).stem,
            "nav_key": "visualization", "permalink": manual_url(source),
            "source_path": source, "source_url": f"{REPOSITORY}/blob/main/{source}",
        }
        # 每项生成一行 key: "value"。JSON 引号字符串也是合法 YAML，无需 PyYAML。
        # ensure_ascii=False 保留中文等字符，不转成 \uXXXX。
        header = "\n".join(f"{key}: {json.dumps(value, ensure_ascii=False)}" for key, value in metadata.items())

        # 4. 转换链接：图片使用 GitHub raw 地址，手册章节使用站内地址。
        body = rewrite(markdown, source)

        # 5. 写入本地：例如 /visualization/topology/ 对应 pages/visualization/topology/index.md。
        output = root / "pages" / manual_url(source).strip("/") / "index.md"
        output.parent.mkdir(parents=True, exist_ok=True)
        # 两行 --- 包围 Jekyll 页头，后面接正文；同名文件会被覆盖。
        output.write_text(f"---\n{header}\n---\n\n{body}", encoding="utf-8", newline="\n")
    print(f"Imported {len(manuals)} visualization manuals; images remain on GitHub.")


# 执行入口：所有函数定义完后才启动主流程，从第 1 步扫描开始。
# 脚本位于 scripts/，往上两级就是网站根目录。
if __name__ == "__main__":
    sync_visualization(Path(__file__).resolve().parent.parent)

# SEED Emulators 网站

这是一个 Jekyll 静态网站。默认英文，支持中文检查与四套配色。
结构分为：**页面内容、一个公共布局、平铺组件、共享数据、静态资源**。

## 本地运行

安装 Ruby 3.3 和 Bundler，在项目根目录执行：

```sh
bundle install
bundle exec jekyll serve --host 127.0.0.1 --port 4173
```

打开 http://127.0.0.1:4173/。修改页面、组件、数据或样式后会自动构建，
刷新浏览器即可看到变化。修改 `_config.yml` 后需重启服务。

只构建，不启动服务：

```sh
bundle exec jekyll build
```

生成结果在 `_site/`。**不要修改 `_site/`，下次构建会覆盖它。**

## 目录：每类文件只负责一件事

```text
index.html                 首页：只组装三个主要区域
internet-emulator/index.html        互联网项目内容、资料和视频
satellite/index.html       卫星项目内容、资料和视频
blockchain/index.html      区块链项目内容、资料和视频
404.html                   必要的错误页面
_config.yml                站点名称、域名、构建配置

_layouts/
  default.html             唯一布局：页首 → 正文 → 页尾，不继承其他布局

_includes/                 所有组件平铺，不再分多层目录
  head.html                元信息、配色初始化、CSS
  header.html              Logo、主导航、配色按钮
  hero.html                首页横幅，直接包含装饰插图
  projects.html            首页项目列表
  project-card.html        一张可复用的项目卡片
  sidebar.html             首页右侧团队和资源
  contact.html             首页底部联系条
  project-page.html        项目详情区：标题、概览、资料、视频
  resource.html            一条可复用的资料记录
  video.html               一个可复用的本地视频播放器
  footer.html              页尾简介、链接和团队信息
  theme-init.html          首屏恢复保存的配色
  theme-picker.html        配色胶囊按钮
  language-toggle.html     中英文切换按钮
  icon.html                共享 SVG 图标
  scripts.html             共享脚本与翻译数据入口

_data/
  home.yml                 首页横幅、项目卡片和联系条文案
  navigation.yml           顶部导航
  footer.yml               页尾和侧栏共用的团队、邮箱、资源链接
  themes.yml               四套配色的唯一数据来源
  zh.json                  英文原文 → 中文翻译

css/
  base.css                 基础排版、可访问性、视频播放器
  main.css                 各区块布局、字号、间距和响应式断点
  themes.css               从 themes.yml 生成配色，以及按钮样式
js/
  site.js                  手机导航和视频错误提示
  theme.js                 配色切换与浏览器保存
  language.js              中文检查模式，支持恢复英文
images/                    正在使用的 Logo、卡片图、视频封面
video/                     正在使用的本地演示视频
scripts/check-site.cjs      构建后检查页面、链接、资源和组件引用
```

## 页面如何调用

所有页面顶部都写 `layout: default`。没有 layout 套 layout：

```text
首页 index.html ───────────────┐
项目页 */index.html ──────────┼─→ default.html → 完整 HTML
404.html ─────────────────────┘
```

`default.html` 的正文区只有一个判断：

```liquid
{% if page.project %}
  {% include project-page.html %}
{% else %}
  {{ content }}
{% endif %}
```

- 首页没有 `project`，直接插入首页组装好的区域。
- 项目页有 `project`，使用 `project-page.html` 组织详情。
  组件里的 `{{ content }}` 插入该项目文件第二个 `---` 后的正文。
- 404 没有 `project`，直接插入错误提示。
- 页首、页尾只在 `default.html` 中调用一次。

组件目录全部平铺，只保留必要的复用：项目列表调用卡片，详情区调用资料行、
视频播放器，各区块调用共享图标。简单列表和装饰插图不再额外拆组件。

## 常见修改位置

| 想修改什么 | 修改哪里 |
| --- | --- |
| 首页标题、简介、项目图片和卡片内容 | `_data/home.yml` |
| 首页区域顺序 | `index.html` |
| 全站公共外壳 | `_layouts/default.html` |
| 项目详情区排列 | `_includes/project-page.html` |
| 某个项目的介绍、资料、视频 | 对应项目的 `index.html` |
| Logo 和导航的结构 | `_includes/header.html` |
| 导航名称与链接 | `_data/navigation.yml` |
| 页尾作者、邮箱和资源 | `_data/footer.yml` |
| 颜色 | `_data/themes.yml` |
| 字号、间距、边框、手机布局 | `css/main.css` |
| 中文文字 | `_data/zh.json` |

页面、组件、CSS 和主要脚本区块带有中文源码注释。Liquid 注释
`{% comment %} ... {% endcomment %}` 构建时会被移除，不显示在网页里。

## 新增项目

1. 复制一个现有项目目录，修改顶部的 `project`、`title`、`category`、
   `description`、`repository`，并修改下方概览正文。
2. 在 `_data/home.yml` 的 `projects` 中添加卡片数据。
3. 在 `_data/navigation.yml` 中添加导航；`key` 与项目的 `project` 一致。
4. 在 `_data/footer.yml` 添加页尾项目链接，必要时补充 `_data/zh.json`。
5. 在 `scripts/check-site.cjs` 的 `pages` 列表中加入新页面，以继续检查全部生成页面。

`resources` 每项包含 `type`、`title`、`description`、`url`。
`url: null` 表示资料尚未提供，页面显示 Coming soon。

`videos` 每项包含 `title`、`description`，并选择以下一种方式：

- 本地视频：`src`，以及可选的 `webm`、`poster`。
- 外部视频：`url`。

没有视频时使用 `videos: []`。未发布的卫星资料继续使用占位数据，
卫星卡片图片是概念示意图。

## 配色、语言与资源

- 配色保存到 localStorage 的 `seed-portal-theme`，跨页面和刷新保持。
- 语言保存到 sessionStorage 的 `seed-review-language`，默认英文。
- 修改英文文案时，同步修改 `_data/zh.json` 中对应的英文键名。
- 图片内部的文字、视频内容和协议名称不会自动翻译。
- 本地链接和图片地址使用 `relative_url`，支持部署到子路径。
- 有 Liquid 的 CSS 文件显式声明 `layout: null`，防止套入页面外壳。

## 已清理的旧版内容

移除了旧版 `why.html`、`how.html`、`capabilities.html`、`cases.html`、
`bsday.html`，以及只供这些页面使用的布局、组件、脚本、主题和重复封面。
互联网项目页不再链接这些旧地址，资料区保留官方文档与演示入口。
旧地址不再生成，访问时由 404 处理。历史内容可从 Git 历史恢复。

## 构建检查与发布

```sh
bundle exec jekyll build
node scripts/check-site.cjs
```

检查器也接受构建目录和部署子路径，例如：

```sh
bundle exec jekyll build --baseurl /preview --destination _site-preview
node scripts/check-site.cjs _site-preview /preview
```

子路径验证请优先使用仓库外的临时目录，避免额外输出被后续构建复制。

正式站点为 https://www.seedemulator.org，发布仓库为
`seed-labs/seedemu-website`。`_config.yml` 的 `url` 与根目录 `CNAME`
均使用正式域名，`baseurl` 保持为空。本地预览命令不变。

GitHub Pages 使用 `.github/workflows/static.yml`：

- 面向 `main` 的 PR：构建并检查页面、链接和资源，不发布。
- 合并或推送到正式仓库的 `main`：检查通过后发布 `_site/`。
- 手动运行：工作流可用的分支都可检查；仅正式仓库的 `main` 可以发布。
- 推送 `test` 或 `development` 不自动发布；已有 PR 的新提交会重新检查。
- Fork 仓库不会通过此工作流部署正式站点。

仓库管理员需在合并前确认以下设置（这些设置不能通过 PR 修改）：

1. `Settings → Pages → Build and deployment → Source` 选择 **GitHub Actions**，
   使用本工作流中的 Jekyll 版本构建，避免同时沿用旧的分支发布方式。
2. `Settings → Pages → Custom domain` 保持 `www.seedemulator.org`，
   DNS 继续指向 `seed-labs.github.io`。自定义 Actions 发布时，`CNAME`
   不会代替这里的域名设置。
3. 如 `github-pages` 环境限制了部署分支，允许 `main` 发布。

合并后在 Actions 中确认 `Build and deploy Jekyll to Pages` 的 `build` 和
`deploy` 均成功，再访问正式域名检查。

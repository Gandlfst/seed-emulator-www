# SEED Emulators website

An English Jekyll website with four selectable color palettes. The structure
separates page content, one shared layout, flat includes, data, and static assets.

## Run locally

Install Ruby 3.3 and Bundler, then run from the repository root:

```sh
bundle install
bundle exec jekyll serve --host 127.0.0.1 --port 4173
```

Open http://127.0.0.1:4173/. Jekyll rebuilds after source changes; refresh the
browser to see them. Restart the server after changing `_config.yml`.

To build without starting a server:

```sh
bundle exec jekyll build
```

Output goes to `_site/`. Do not edit generated files.

## Project structure

```text
index.html                    Homepage: assembles three main sections
internet-emulator/index.html  Internet project content and resources
satellite/index.html          Satellite project content and resources
blockchain/index.html         Blockchain project content and resources
about-us/index.html           Project lead, core developers, and contributors
examples/index.html           Two-level example catalog with search
_examples/                    One Markdown file per guided example
404.html                      Not-found page
_config.yml                   Metadata, canonical domain, and build settings
CNAME                         Official domain
_layouts/default.html         Single shared page layout
_includes/                    Flat, reusable components
_data/home.yml                Hero, project cards, and contact strip
_data/navigation.yml          Navigation links and active-page keys
_data/footer.yml              Shared footer and sidebar information
_data/themes.yml              Four palettes and their CSS variables
_data/team.yml                Team members and GitHub usernames
_data/examples.yml            Example categories and upstream source revision
css/base.css                  Reset, typography, accessibility, and video
css/main.css                  Page sections and responsive layouts
css/themes.css                Generated theme variables and theme controls
css/examples.css              Example catalog and course-style lesson layouts
js/site.js                    Mobile navigation and video errors
js/theme.js                   Theme switching and saved preferences
js/examples.js                Progressive catalog filtering
images/                       Logo, project illustrations, and posters
video/                        Local demonstration videos
scripts/check-site.cjs         Generated-page and component validation
```

All pages explicitly declare `layout: default`. The layout adds the shared
header and footer. Project pages set `project` and render through
`project-page.html`; the homepage and 404 insert their own content directly.
Layouts do not inherit other layouts.

The homepage includes `hero.html`, then `projects.html` and `sidebar.html`
inside a grid, followed by `contact.html`. The project list renders
`project-card.html` for each record in `_data/home.yml`.

Project details use `resource.html` for resources and `video.html` for local
players. Other shared includes are `head.html`, `header.html`, `footer.html`,
`icon.html`, `theme-init.html`, `theme-picker.html`, and `scripts.html`.
All includes live directly in `_includes/`.

The Internet Emulator resource list links to `/examples/`. This catalog renders
`examples-catalog.html`, groups the `_examples` collection by category, and uses
`example-row.html` for each entry. Each row opens a local lesson. The shared
layout renders pages with `example: true` through `example-course.html`, with
chapter navigation beside the Markdown content. There are no nested layouts.

To add a lesson, copy a Markdown file in `_examples/`, update its title, code,
category, `source_path`, and lesson text. Its filename becomes its URL under
`/examples/`. Category IDs, default chapters, resource labels, and the source
revision come from `_data/examples.yml`. A lesson may override `chapters` when
its section headings differ. Keep chapter IDs in sync with Markdown headings.
The site checker discovers lessons automatically.

`example-setup.html` holds shared prerequisites and reads the lesson's
`source_path`. Each lesson includes it under Before you start. The course
component builds pinned source URLs and reuses `resource.html`, the same rows
used by project pages. Feedback and help are shared in `example-course.html`.
Only example-specific guidance and metadata belong in individual Markdown files.
The initial collection contains 20 selected examples across four categories,
summarized from upstream READMEs at the revision recorded in the catalog data.
Source links are pinned to that revision so the material remains traceable.

The About us page renders `team.html`, which groups people into Project Lead,
Core Developers, and Contributors. Each person uses `team-member.html`.
Edit `_data/team.yml` to maintain the roster. Core Developers starts empty;
replace `core_developers: []` with a list when the names are ready:

```yaml
core_developers:
  - name: Full Name
    github: github-username
    affiliation: University or organization
```

The GitHub username and affiliation are optional. Keep contributors in
alphabetical order. Navigation uses `nav_key: about` for this standalone page.

Source comments explain each section in English. Liquid comments are removed
during the build. The website is English-only.

## Common changes

| Change | File |
| --- | --- |
| Homepage copy, cards, and images | `_data/home.yml` |
| Homepage section order | `index.html` |
| Shared page shell | `_layouts/default.html` |
| Project detail structure | `_includes/project-page.html` |
| Project copy, resources, and videos | The project's `index.html` |
| Header and logo markup | `_includes/header.html` |
| Transparent logo artwork | `images/seed-emulator-logo.png` |
| Navigation links | `_data/navigation.yml` |
| Team details and resource links | `_data/footer.yml` |
| About us member lists | `_data/team.yml` |
| Example categories and source revision | `_data/examples.yml` |
| Example lesson text and chapters | `_examples/*.md` |
| Catalog and lesson presentation | `css/examples.css` |
| Colors | `_data/themes.yml` |
| Spacing, typography, and responsive layout | `css/main.css` |

The supplied logo is rendered as a transparent PNG with its original colors
and details intact, without a solid backing, color mask, or extra filter.
CSS clips unused transparent space without modifying the source image.

## Add a project

1. Copy an existing project directory. Update `project`, `title`, `category`,
   `description`, `repository`, and the overview content.
2. Add a card to `projects` in `_data/home.yml`.
3. Add navigation in `_data/navigation.yml`; its `key` must match `project`.
4. Add footer links in `_data/footer.yml` as needed.
5. Add the generated page path to `sourcePages` in `scripts/check-site.cjs`.

Each resource has `type`, `title`, `description`, and `url`.
Use `url: null` for resources that are not yet available.

Each video has `title` and `description`, plus either a local `src`
(with optional `webm` and `poster`) or an external `url`.
Use `videos: []` when no videos are available.

The satellite card is a concept illustration. Its unpublished materials retain
Coming soon placeholders.

## Themes and assets

- Themes persist in localStorage under `seed-portal-theme`.
- Local URLs use `relative_url` to support deployment under a base path.
- Generated CSS explicitly sets `layout: null` to avoid HTML wrappers.
- The old why, how, capabilities, cases, and birthday pages were removed.
  Their historical versions remain available in Git.

## Validate and publish

```sh
bundle exec jekyll build
node scripts/check-site.cjs
```

The checker validates pages, local links, assets, anchors, English-only output,
and the flat include structure. It also accepts an output directory and base path:

```sh
bundle exec jekyll build --baseurl /preview --destination ../seedemu-preview
node scripts/check-site.cjs ../seedemu-preview /preview
```

Use a temporary directory outside the repository for alternate builds.

The production site is https://www.seedemulator.org, published from
`seed-labs/seedemu-website`. Both `_config.yml` and `CNAME` use the official
domain; `baseurl` is empty. Local preview commands stay the same.

The workflow in `.github/workflows/static.yml` behaves as follows:

- Pull requests targeting `main` build and validate without publishing.
- Pushes or merges to the official repository's `main` publish after validation.
- Manual runs validate wherever the workflow is available; only official
  `main` may deploy.
- Pushes to `test` or `development` do not publish. Updates to an open PR
  rerun its checks.
- Forks do not deploy the production site through this workflow.

Before merging, a repository administrator must confirm:

1. **Settings → Pages → Build and deployment → Source** is **GitHub Actions**.
   This uses the Jekyll version in the workflow instead of the old branch build.
2. **Custom domain** remains `www.seedemulator.org`, with DNS pointing to
   `seed-labs.github.io`. For custom Actions deployments, `CNAME` does not
   replace the domain setting in GitHub.
3. If the `github-pages` environment restricts deployment branches, it allows
   `main`.

After merging, confirm that both build and deploy succeed in Actions, then
check the production site.

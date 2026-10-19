# SEED Emulators website

An English Jekyll website using the Teal palette, with visitor theme controls hidden.
The homepage explicitly renders three projects: Internet, Satellite, and Blockchain.

## Run locally

Install Ruby 3.3 and Bundler, then run from the repository root:

```sh
bundle install
bundle exec jekyll serve --host 127.0.0.1 --port 4173
```

Open http://127.0.0.1:4173/. Restart Jekyll after changing `_config.yml`.
Build without a server using `bundle exec jekyll build`. `_site/` contains generated
output; edit the source files instead.

## Project structure

```text
index.html                         Homepage
pages/
  internet-emulator/                Project entry, presentation/, screenshots/
  satellite/                       Project entry, presentation/, screenshots/
  blockchain/                      Project entry, presentation/, screenshots/
  about-us/                        Team page
  examples/
    index.html                     Example catalog
    _examples/                     URL stubs for individual examples
    _example_readmes/               Imported upstream README pages
  papers/                          Shared publications page
  in-action/                       Shared applications page
_data/
  internet/                        Internet project content, images/, video/
  satellite/                       Satellite project content and images/
  blockchain/                      Blockchain project content and images/
  shared/
    images/                        Shared logo and mark
    examples.yml                   Categories, resource labels, upstream revision
    themes.yml                     Palette definitions
  about-us/
    team.yml                       Team members and GitHub usernames
_layouts/default.html              Single shared layout
_includes/single-use/              Page-specific includes grouped by page name
_includes/shared/                  Shared components
css/                               Styles
js/                                Navigation and example filtering
scripts/sync-example-readmes.rb     Minimal README downloader
```

Pages declare explicit permalinks, so their public URLs do not include `/pages/`.
`collections_dir: pages/examples` locates both example collections. Their URLs
remain `/examples/<slug>/` and `/examples/<slug>/readme/`.

Short fixed copy belongs directly in its page or include. Header, footer, hero,
and sidebar each own their text. Papers and In Action keep their small lists in
page front matter. Project introductions also live in their project pages; child
resource pages look up that page for the parent title and link.

Each project data folder contains:

- `card.yml`: homepage card copy and image, independent from project details.
- `resources.yml`: presentation entries.
- `videos.yml`: video entries, or `[]` when empty.
- `screenshots.yml`: actual screenshots and captions.
- `examples.yml`: example metadata, descriptions, source paths, and overview text.

Local video files live in `video/` (singular) to avoid colliding with `videos.yml`
in Jekyll's data namespace. Project images live in their respective `images/`
folders. Add each new static asset to `_config.yml`'s `include` list; Jekyll
otherwise excludes files under `_data`. YAML content is not published as assets.

## Page composition

The shared `default` layout adds the header, footer, and scripts. Project pages
keep copy in page front matter, select a media data folder, and render `project-page.html`. Layouts are not nested.

The homepage uses `_includes/single-use/home/` for its hero, projects, and
sidebar. The three cards are authored explicitly in projects.html, without iterating over projects.
Other page-specific includes are grouped under `about-us`.
The three projects share `shared/example-catalog.html` and `shared/example-row.html` for the example catalog and its entries.
Papers and In Action share `resource-list-page.html`, passing their own page.items lists from page front matter.
Shared readers, resource rows, videos, and icons live under `_includes/shared/`.

Project resources appear in this order: Presentation, Example, Paper, Screenshots.
Presentation and Screenshots have project-specific pages. Paper links to the shared
`/papers/` page; `/in-action/` is also shared. Empty resource lists can be populated
later. Screenshots should show the running application, not concept illustrations.

## Example content

The catalog currently contains 30 examples across four categories. Edit each
example in its owning project's `examples.yml`. Short `description` text appears
in the catalog; `overview` appears on the detail page. A matching Markdown stub
in `pages/examples/_examples/` supplies layout and routing settings.

To add an example:

1. Add a record with `title`, `description`, `code`, `category_id`, `source_path`,
   `slug`, `url`, and `overview` to the owning project's `examples.yml`.
2. Add `pages/examples/_examples/<slug>.md` using an existing stub as a template.
3. Run the README importer and build the site.

Each detail page contains an Overview and Instructions and Code. The README link
opens a local page; the code link opens the upstream directory at the revision
recorded in `_data/shared/examples.yml`. The existing `A15_toplogy_generator` spelling
matches the upstream path and is intentional.

## Import example READMEs

```sh
ruby scripts/sync-example-readmes.rb
bundle exec jekyll build
```

The script reads the three project example lists and downloads only each
`source_path/README.md` from `seed-labs/seed-emulator` on `master`. It writes the
unchanged Markdown to `pages/examples/_example_readmes/<slug>.md`, preceded by:

```yaml
---
layout: default
---
```

The script does not clone the repository, convert Markdown, or download images.
On Windows it defaults to `http://127.0.0.1:7890` unless `https_proxy` or
`HTTPS_PROXY` is already set. Set `https_proxy` to an empty string for a direct
connection. Linux and macOS retain their existing proxy settings.

Collection defaults disable Liquid evaluation in imported README text. The layout
looks up the matching example by filename. `_includes/shared/example-readme.html` supplies
the reader, return link, and View on GitHub link. It maps the D01 image reference to
`/_data/blockchain/images/POS-1.png` and A11's two relative sub-guide links to GitHub.
Additional guide links can be mapped for display with an example's readme_links list
(from and to); this does not modify imported Markdown. Other relative references
remain as supplied upstream; use View on GitHub when needed.

Commit imported READMEs along with their example records and stubs. Jekyll builds
do not fetch from GitHub. Re-running the importer overwrites imported text; edit
authored introductions in project data instead. Remove corresponding generated
files manually when removing an example; the importer does not delete files.

## Common edits

| Change | File |
| --- | --- |
| Homepage heading and introduction | `_includes/single-use/home/hero.html` |
| Homepage sidebar | `_includes/single-use/home/sidebar.html` |
| Homepage cards | `_data/<project>/card.yml` |
| Project descriptions and overviews | `pages/<project>/index.html` |
| Example descriptions and overviews | `_data/<project>/examples.yml` |
| Shared papers and applications | `pages/papers/index.html`, `pages/in-action/index.html` |
| Team member lists and GitHub avatars | `_data/about-us/team.yml` |
| Footer | `_includes/shared/footer.html` |
| Navigation | `_includes/shared/header.html` |
| Colors | `_data/shared/themes.yml`, `portal_theme` in `_config.yml` |
| Page layout and typography | `css/main.css`, `css/examples.css` |

Team entries use `name`, optional `github`, and optional `affiliation`. GitHub
avatars use the username, with initials as a fallback. The footer and homepage
sidebar maintain separate copy because their available space differs.

`show_theme_picker: false` hides visitor theme controls. Local links use
`relative_url` to support a base path. Small WebP project illustrations are used
on the homepage; full-size originals remain available in the project data folders.


## Build and publish

```sh
bundle exec jekyll build
```

To preview deployment under a base path:

```sh
bundle exec jekyll build --baseurl /preview --destination ../seedemu-preview
```

Use a temporary directory outside the repository for alternate builds.

The production site is https://www.seedemulator.org, published from
`seed-labs/seedemu-website`. Both `_config.yml` and `CNAME` use the official
domain; `baseurl` is empty. Local preview commands stay the same.

The workflow in `.github/workflows/static.yml` behaves as follows:

- Pull requests targeting `main` build without publishing.
- Pushes or merges to the official repository's `main` publish after a successful build.
- Manual runs build wherever the workflow is available; only official
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

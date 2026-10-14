// Validate generated pages, local links, assets, anchors, and component references.
// Usage: node scripts/check-site.cjs [output-directory] [baseurl]
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const root = path.resolve(__dirname, '..');
const output = path.resolve(process.argv[2] || path.join(root, '_site'));
const baseurl = (process.argv[3] || '').replace(/\/$/, '');
const sourcePages = ['index.html', 'internet-emulator/index.html', 'satellite/index.html', 'blockchain/index.html', 'about-us/index.html', 'examples/index.html', '404.html'];
// Collection filenames determine their public lesson URLs; no manual page registry is needed.
const lessons = fs.readdirSync(path.join(root, '_examples')).filter(name => name.endsWith('.md'));
const pages = [...sourcePages, ...lessons.map(name => `examples/${name.slice(0, -3)}/index.html`)];
const read = file => fs.readFileSync(file, 'utf8');
const walk = dir => fs.readdirSync(dir, { withFileTypes: true }).flatMap(item => item.isDirectory() ? walk(path.join(dir, item.name)) : [path.join(dir, item.name)]);
const clean = html => html.replace(/(<script\b[^>]*>)[\s\S]*?<\/script>/gi, '$1').replace(/<!--[\s\S]*?-->/g, '');

// Expect the configured pages, each with one shared header, footer, and main element.
assert.deepEqual(walk(output).filter(file => file.endsWith('.html')).map(file => path.relative(output, file).replaceAll('\\', '/')).sort(), [...pages].sort());
let checkedLinks = 0;
for (const page of pages) {
  const html = read(path.join(output, page));
  assert(!/{%|{{/.test(html), `${page}: Liquid was not rendered`);
  for (const tag of ['header', 'main', 'footer']) assert.equal((html.match(new RegExp(`<${tag}\\b`, 'g')) || []).length, 1, `${page}: duplicate or missing ${tag}`);
  assert.equal((html.match(/data-portal-theme="/g) || []).length, 4, `${page}: expected four theme buttons`);
  assert(!/data-language-toggle|seed-language-config|\/js\/language\.js/.test(html), `${page}: obsolete translation controls`);
  assert(!/\p{Script=Han}/u.test(html), `${page}: unexpected Chinese text`);
  const navigation = html.match(/<nav class="main-navigation"[\s\S]*?<\/nav>/)[0];
  assert.equal((navigation.match(/aria-current="page"/g) || []).length, page === '404.html' ? 0 : 1, `${page}: invalid active navigation`);
  const url = new URL(`${baseurl}/${page.replace(/index\.html$/, '')}`, 'https://local.test');
  for (const match of clean(html).matchAll(/\b(?:href|src|poster)="([^"]+)"/g)) {
    const raw = match[1].replaceAll('&amp;', '&');
    const target = new URL(raw, url);
    if (target.origin !== url.origin) continue;
    if (baseurl) assert(target.pathname.startsWith(baseurl + '/'), `${page}: link escaped baseurl: ${raw}`);
    const relative = decodeURIComponent(target.pathname.slice(baseurl.length)).replace(/^\//, '');
    let file = path.resolve(output, relative);
    assert(file === output || file.startsWith(output + path.sep), `${page}: path escapes output`);
    assert(fs.existsSync(file), `${page}: missing local target ${raw}`);
    if (fs.statSync(file).isDirectory()) file = path.join(file, 'index.html');
    assert(fs.existsSync(file), `${page}: missing index ${raw}`);
    if (target.hash && file.endsWith('.html')) {
      const fragment = decodeURIComponent(target.hash.slice(1));
      const ids = [...read(file).matchAll(/\bid="([^"]+)"/g)].map(item => item[1]);
      assert(ids.includes(fragment), `${page}: missing anchor ${raw}`);
    }
    checkedLinks++;
  }
}

// Stylesheets must contain CSS, not page HTML or unresolved Liquid.
for (const name of ['base', 'main', 'themes', 'examples']) {
  const css = read(path.join(output, `css/${name}.css`));
  assert(!/<html|<!doctype|{%|{{/i.test(css), `${name}.css: invalid generated CSS`);
}
// Includes stay flat; check that references exist and no unused components remain.
const includes = path.join(root, '_includes');
const used = new Set();
function follow(text, chain = []) {
  for (const match of text.matchAll(/{%\s*include\s+([^\s%]+)/g)) {
    const name = match[1];
    assert(!name.includes('/'), `Nested include path: ${name}`);
    assert(!chain.includes(name), `Recursive include: ${name}`);
    const file = path.join(includes, name);
    assert(fs.existsSync(file), `Missing include: ${name}`);
    used.add(name);
    follow(read(file), [...chain, name]);
  }
}
for (const file of ['_layouts/default.html', ...sourcePages, ...lessons.map(name => `_examples/${name}`)]) follow(read(path.join(root, file)));
assert.deepEqual(fs.readdirSync(path.join(root, '_layouts')), ['default.html']);
assert.deepEqual(fs.readdirSync(includes).sort(), [...used].sort());
console.log(`PASS: ${pages.length} pages, ${checkedLinks} local links/assets, ${used.size} flat includes, one layout (${baseurl || '/'}).`);

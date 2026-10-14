// Filter the static example catalog without changing URLs or loading remote data.
(() => {
  const control = document.querySelector('[data-example-search]');
  if (!control) return;
  const input = control.querySelector('input');
  const rows = [...document.querySelectorAll('[data-example-row]')];
  const groups = [...document.querySelectorAll('[data-example-group]')];
  const count = document.querySelector('[data-example-count]');
  const empty = document.querySelector('[data-example-empty]');
  const filter = () => {
    const words = input.value.toLowerCase().trim().split(/\s+/).filter(Boolean);
    let visible = 0;
    rows.forEach(row => {
      const searchable = `${row.textContent} ${row.dataset.exampleCategory}`.toLowerCase();
      row.hidden = !words.every(word => searchable.includes(word));
      if (!row.hidden) visible++;
    });
    groups.forEach(group => { group.hidden = ![...group.querySelectorAll('[data-example-row]')].some(row => !row.hidden); });
    count.textContent = `${visible} ${visible === 1 ? 'example' : 'examples'}`;
    empty.hidden = visible !== 0;
  };
  input.addEventListener('input', filter);
  input.addEventListener('search', filter);
  // Category links reset a search so their destination cannot remain hidden.
  document.querySelectorAll('.examples-sidebar nav a').forEach(link => link.addEventListener('click', () => { input.value = ''; filter(); }));
  filter();
  control.hidden = false;
})();

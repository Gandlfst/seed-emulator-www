// 配色交互：切换主题、更新按钮状态，并通过 localStorage 保存选择。
(() => {
  'use strict';
  const picker = document.querySelector('[data-portal-palette]');
  if (!picker) return;
  const themes = JSON.parse(document.getElementById('portal-theme-config').textContent);
  const buttons = [...picker.querySelectorAll('[data-portal-theme]')];
  const storageKey = 'seed-portal-theme';
  const apply = id => {
    const theme = themes.find(item => item.id === id) || themes[0];
    document.documentElement.dataset.portalTheme = theme.id;
    document.querySelector('meta[name="theme-color"]').content = theme.background;
    buttons.forEach(button => button.setAttribute('aria-pressed', String(button.dataset.portalTheme === theme.id)));
    return theme.id;
  };
  buttons.forEach(button => button.addEventListener('click', () => {
    const id = apply(button.dataset.portalTheme);
    try { localStorage.setItem(storageKey, id); } catch (_) { /* The current page still works without storage. */ }
  }));
  window.addEventListener('storage', event => {
    if (event.key === storageKey || event.key === null) apply(event.newValue);
  });
  window.addEventListener('pageshow', () => {
    try { apply(localStorage.getItem(storageKey)); } catch (_) {}
  });
  apply(document.documentElement.dataset.portalTheme);
  picker.hidden = false;
})();

// Page interactions: navigation, resource dropdown, and team avatar fallbacks.
(() => {
  'use strict';
  document.documentElement.classList.add('js-enabled');

  const toggle = document.querySelector('.menu-toggle');
  const navigation = document.querySelector('.main-navigation');
  const resources = document.querySelector('.portal-resources');
  const closeResources = (restoreFocus = false) => {
    if (!resources?.open) return false;
    resources.open = false;
    if (restoreFocus) resources.querySelector('summary').focus();
    return true;
  };
  const narrowViewport = window.matchMedia('(max-width: 960px)');
  const setMenu = (open, restoreFocus = false) => {
    navigation.classList.toggle('is-open', open);
    toggle.setAttribute('aria-expanded', String(open));
    toggle.setAttribute('aria-label', open ? 'Close navigation' : 'Open navigation');
    if (!open) closeResources();
    if (open && narrowViewport.matches) navigation.querySelector('a')?.focus();
    if (restoreFocus) toggle.focus();
  };
  if (toggle && navigation) {
    toggle.addEventListener('click', () => setMenu(toggle.getAttribute('aria-expanded') !== 'true'));
    navigation.addEventListener('click', event => {
      if (event.target.closest('a')) setMenu(false);
    });
    document.addEventListener('keydown', event => {
      if (event.key !== 'Escape') return;
      if (closeResources(true)) event.preventDefault();
      else if (toggle.getAttribute('aria-expanded') === 'true') setMenu(false, true);
    });
    document.addEventListener('click', event => {
      if (!event.target.closest('.portal-resources')) closeResources();
      if (!event.target.closest('.site-header')) setMenu(false);
    });
    narrowViewport.addEventListener('change', () => setMenu(false));
  }
  resources?.addEventListener('focusout', event => {
    if (!resources.contains(event.relatedTarget)) closeResources();
  });

  // Keep the member initial visible when a GitHub avatar cannot be loaded.
  document.querySelectorAll('.team-member-avatar').forEach(avatar => {
    const showInitial = () => { avatar.hidden = true; };
    avatar.addEventListener('error', showInitial);
    if (avatar.complete && avatar.naturalWidth === 0) showInitial();
  });
})();

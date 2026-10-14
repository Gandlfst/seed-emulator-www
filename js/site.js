// Page interactions: mobile navigation and local video error feedback.
(() => {
  'use strict';
  document.documentElement.classList.add('js-enabled');

  const toggle = document.querySelector('.menu-toggle');
  const navigation = document.querySelector('.main-navigation');
  const narrowViewport = window.matchMedia('(max-width: 960px)');
  const setMenu = (open, restoreFocus = false) => {
    navigation.classList.toggle('is-open', open);
    toggle.setAttribute('aria-expanded', String(open));
    toggle.setAttribute('aria-label', open ? 'Close navigation' : 'Open navigation');
    if (open && narrowViewport.matches) navigation.querySelector('a')?.focus();
    if (restoreFocus) toggle.focus();
  };
  if (toggle && navigation) {
    toggle.addEventListener('click', () => setMenu(toggle.getAttribute('aria-expanded') !== 'true'));
    navigation.addEventListener('click', event => {
      if (event.target.closest('a')) setMenu(false);
    });
    document.addEventListener('keydown', event => {
      if (event.key === 'Escape' && toggle.getAttribute('aria-expanded') === 'true') setMenu(false, true);
    });
    document.addEventListener('click', event => {
      if (!event.target.closest('.site-header')) setMenu(false);
    });
    narrowViewport.addEventListener('change', () => setMenu(false));
  }

  // Show a fallback file link when video loading fails.
  document.querySelectorAll('.video-panel video').forEach(video => {
    const errorMessage = video.closest('.video-panel').querySelector('.video-error');
    video.addEventListener('error', () => { errorMessage.hidden = false; });
    video.addEventListener('loadeddata', () => { errorMessage.hidden = true; });
  });

})();

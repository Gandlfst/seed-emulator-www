(() => {
  'use strict';
  const root = document.documentElement;
  const title = document.querySelector('title[data-title-en]');
  const chineseTitle = title?.textContent;
  const controls = document.querySelector('[data-display-controls]');
  const languageButton = controls?.querySelector('[data-language-toggle]');
  const fullscreenButton = controls?.querySelector('[data-fullscreen-toggle]');

  function setLanguage(language) {
    root.dataset.siteLanguage = language;
    if (root.hasAttribute('data-localized-page')) root.lang = language === 'en' ? 'en' : 'zh-CN';
    if (title) document.title = language === 'en' ? title.dataset.titleEn : chineseTitle;
    document.querySelectorAll('[data-zh-label]').forEach(element => {
      element.setAttribute('aria-label', language === 'en' ? element.dataset.enLabel : element.dataset.zhLabel);
    });
    document.querySelectorAll('[data-zh-alt]').forEach(image => {
      image.alt = language === 'en' ? image.dataset.enAlt : image.dataset.zhAlt;
    });
    document.dispatchEvent(new Event('site-language-change'));
  }

  setLanguage(root.dataset.siteLanguage === 'en' ? 'en' : 'zh');
  if (!controls) return;
  controls.hidden = false;
  languageButton.addEventListener('click', () => {
    const language = root.dataset.siteLanguage === 'en' ? 'zh' : 'en';
    setLanguage(language);
    try {
      localStorage.setItem('seed-site-language', language);
    } catch (error) {}
  });

  const enter = fullscreenButton.querySelector('[data-fullscreen-enter]');
  const exit = fullscreenButton.querySelector('[data-fullscreen-exit]');
  const status = controls.querySelector('[data-fullscreen-status]');
  document.addEventListener('fullscreenchange', () => {
    const active = document.fullscreenElement === root;
    enter.hidden = active;
    exit.hidden = !active;
  });
  fullscreenButton.addEventListener('click', async () => {
    status.hidden = true;
    try {
      if (document.fullscreenElement === root) {
        await document.exitFullscreen();
      } else {
        await root.requestFullscreen();
        const cover = document.querySelector('.deck-cover');
        if (cover) cover.scrollIntoView({ behavior: 'instant' });
        else window.scrollTo({ top: 0, behavior: 'instant' });
      }
    } catch (error) {
      status.hidden = false;
    }
  });
})();

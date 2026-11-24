(() => {
  'use strict';
  const navigation = document.querySelector('[data-deck-nav]');
  if (!navigation) return;

  const chapters = [...navigation.querySelectorAll('a[href^="#"]')]
    .map(link => ({ link, section: document.getElementById(link.hash.slice(1)) }))
    .filter(chapter => chapter.section);
  if (!chapters.length) return;

  let current = chapters.find(({ link }) => link.hasAttribute('aria-current'));
  let pending = false;

  function updateChapter() {
    pending = false;
    const boundary = navigation.getBoundingClientRect().bottom + 48;
    const atEnd = window.scrollY > 0 && window.scrollY + window.innerHeight >= document.documentElement.scrollHeight - 2;
    const visibleChapters = chapters.filter(({ link }) => link.getClientRects().length);
    const active = atEnd ? visibleChapters[visibleChapters.length - 1]
      : visibleChapters.findLast(({ section }) => section.getBoundingClientRect().top <= boundary) || chapters[0];
    if (current !== active) {
      current?.link.removeAttribute('aria-current');
      active.link.setAttribute('aria-current', 'location');
      current = active;
    }

    const strip = active.link.parentElement;
    const linkRect = active.link.getBoundingClientRect();
    const stripRect = strip.getBoundingClientRect();
    if (linkRect.left < stripRect.left || linkRect.right > stripRect.right) {
      strip.scrollLeft += linkRect.left - stripRect.left - (strip.clientWidth - linkRect.width) / 2;
    }
  }

  function scheduleUpdate() {
    if (pending) return;
    pending = true;
    requestAnimationFrame(updateChapter);
  }

  addEventListener('scroll', scheduleUpdate, { passive: true });
  addEventListener('resize', scheduleUpdate);
  addEventListener('pageshow', scheduleUpdate);
  document.addEventListener('site-language-change', scheduleUpdate);
  updateChapter();
})();

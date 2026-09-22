(() => {
  const C = window.INVITACION;
  if (!C) return;

  const pathGet = (obj, path) => path.split('.').reduce((a,k)=>a?.[k], obj);
  const assetSrc = (key) => {
    const a = C.assets[key];
    if (!a) return '';
    return C.assetMode === 'local' ? `assets/images/${a.file}` : a.url;
  };

  document.documentElement.style.setProperty('--page-bg', `url("${assetSrc('background')}")`);
  document.title = `${C.titulo} | ${C.nombre}`;

  document.querySelectorAll('[data-text]').forEach(el => el.textContent = C[el.dataset.text] ?? '');
  document.querySelectorAll('[data-path]').forEach(el => el.textContent = pathGet(C, el.dataset.path) ?? '');
  document.querySelectorAll('[data-list-path]').forEach(el => {
    const items = pathGet(C, el.dataset.listPath);
    if (Array.isArray(items)) {
      el.replaceChildren(...items.map(item => {
        const li = document.createElement('li');
        li.textContent = item;
        return li;
      }));
    }
  });
  document.querySelectorAll('[data-asset]').forEach(el => {
    el.src = assetSrc(el.dataset.asset);
    el.loading = el.closest('.hero') ? 'eager' : 'lazy';
  });

  const audio = document.getElementById('bg-audio');
  const toggle = document.getElementById('sound-toggle');
  if (C.musicaUrl) {
    audio.src = C.musicaUrl;
    audio.pause();
    audio.addEventListener('loadedmetadata', () => {
      if (C.musicaDesdeSegundo > 0) audio.currentTime = C.musicaDesdeSegundo;
    }, {once:true});
  }
  const startMusic = async () => {
    if (!C.musicaUrl) return;
    if (audio.readyState > 0 && C.musicaDesdeSegundo > 0) {
      audio.currentTime = C.musicaDesdeSegundo;
    }
    try { await audio.play(); toggle.textContent = '♪'; } catch (_) {}
  };

  const introScreen = document.getElementById('intro-screen');
  const introVideo = document.getElementById('intro-video');
  const introSkip = document.getElementById('intro-skip');
  if (introScreen && introVideo && C.introVideo) {
    introVideo.src = C.introVideo;
    let introClosed = false;
    const closeIntro = (playMusic = false) => {
      if (introClosed) return;
      introClosed = true;
      introScreen.classList.add('is-hidden');
      if (playMusic) startMusic();
      window.setTimeout(() => { introScreen.hidden = true; }, 900);
    };
    introVideo.addEventListener('ended', () => closeIntro(true), {once:true});
    introVideo.addEventListener('error', () => closeIntro(true), {once:true});
    introSkip.addEventListener('click', () => closeIntro(true), {once:true});
    introScreen.addEventListener('click', event => {
      if (event.target !== introSkip) {
        introScreen.classList.add('sound-started');
        introVideo.muted = false;
        introVideo.volume = 1;
        introVideo.play().catch(() => {});
      }
    });
    introVideo.play().catch(() => {});
  } else if (introScreen) {
    introScreen.hidden = true;
  }

  const maps = document.getElementById('maps-link');
  const rsvp = document.getElementById('rsvp-link');
  if (maps) maps.href = C.evento.maps;
  if (rsvp) rsvp.href = C.rsvp.whatsapp;

  const target = new Date(C.fechaISO).getTime();
  const pad = n => String(Math.max(0,n)).padStart(2,'0');
  const tick = () => {
    const diff = Math.max(0, target - Date.now());
    const days = Math.floor(diff / 86400000);
    const hours = Math.floor(diff % 86400000 / 3600000);
    const minutes = Math.floor(diff % 3600000 / 60000);
    const seconds = Math.floor(diff % 60000 / 1000);
    document.getElementById('days').textContent = pad(days);
    document.getElementById('hours').textContent = pad(hours);
    document.getElementById('minutes').textContent = pad(minutes);
    document.getElementById('seconds').textContent = pad(seconds);
  };
  tick(); setInterval(tick,1000);

  const io = new IntersectionObserver(entries => entries.forEach(e => {
    if (e.isIntersecting) e.target.classList.add('is-visible');
  }), {threshold:.14});
  document.querySelectorAll('.reveal').forEach(el => io.observe(el));

  document.querySelectorAll('[data-modal-open]').forEach(button => {
    button.addEventListener('click', () => {
      const modal = document.getElementById(button.dataset.modalOpen);
      if (modal) modal.hidden = false;
    });
  });
  document.querySelectorAll('[data-modal-close]').forEach(button => {
    button.addEventListener('click', () => { button.closest('.gift-modal').hidden = true; });
  });
  document.querySelectorAll('.gift-modal').forEach(modal => {
    modal.addEventListener('click', event => {
      if (event.target === modal) modal.hidden = true;
    });
  });

  if (C.musicaUrl) {
    toggle.hidden = false;
    toggle.addEventListener('click', async () => {
      if (audio.paused) { try { await audio.play(); toggle.textContent='♪'; } catch(_){} }
      else { audio.pause(); toggle.textContent='×'; }
    });
  }
})();


(function () {
  const app = document.getElementById('app');
  const painelAtivas = document.getElementById('painel-ativas');
  const painelConcluidas = document.getElementById('painel-concluidas');

  function reanimateEnter(el){
    el.classList.remove('enter');
    void el.offsetWidth; // reflow
    el.classList.add('enter');
  }

  // Animação de remoção padrão (usada na lixeira e no checkbox)
  function animateLeaveAndThen(card, after){
    // 1) trava altura atual para permitir transição de height
    card.style.height = card.offsetHeight + 'px';
    // 2) força reflow
    card.getBoundingClientRect();
    // 3) inicia fade+slide
    card.classList.add('leaving');
    // 4) próximo frame: colapsa altura e espaçamentos
    requestAnimationFrame(() => {
      card.classList.add('collapsing');
      const onEnd = (ev) => {
        if (ev.propertyName !== 'height') return;
        card.removeEventListener('transitionend', onEnd);
        after();
      };
      card.addEventListener('transitionend', onEnd);
    });
  }

  // Mover entre abas ao marcar/desmarcar, com a MESMA animação de saída
  app.addEventListener('change', function(e){
    const target = e.target;
    if (!target.matches('.checkbox-container input[type="checkbox"]')) return;

    const card = target.closest('.task');
    if (!card) return;

    const checked = target.checked;
    const toPanel = checked ? painelConcluidas : painelAtivas;

    animateLeaveAndThen(card, () => {
      // move e prepara estado visual
      if (checked) {
        card.classList.add('opaco');
      } else {
        card.classList.remove('opaco');
      }

      // limpa classes/estilos de saída antes de reentrar
      card.classList.remove('leaving','collapsing');
      card.style.height = ''; // libera para altura natural

      // insere no destino e reanima entrada
      toPanel.appendChild(card);
      reanimateEnter(card);
    });
  });

  // Remoção com animação (lixeira)
  app.addEventListener('click', function(e){
    const btn = e.target.closest('.btn.trash');
    if (!btn) return;

    const card = btn.closest('.task');
    if (!card) return;

    animateLeaveAndThen(card, () => {
      card.remove();
    });
  });
})();

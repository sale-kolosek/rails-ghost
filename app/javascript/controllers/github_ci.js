document.addEventListener('turbo:load', () => {
  const container = document.querySelector('.img-slider-container');
  document.querySelector('.slider').addEventListener('input', (e) => {
     container.style.setProperty('--position', `${e.target.value}%`);
  });
});
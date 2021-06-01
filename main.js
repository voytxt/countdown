const countdown = document.getElementById('countdown');
const menu = document.getElementById('menu');
const customDate = document.getElementById('datePicker');
const customTime = document.getElementById('timePicker');

const currentYear = new Date().getFullYear();
let endDate = new Date(`June 30 ${currentYear} 13:00`);
if (endDate < new Date()) endDate.setFullYear(currentYear + 1);
let divideTimeBy = 1;
let splitChar = ' ';

customDate.value = new Date().toLocaleDateString().split('/').reverse().join('-');
customTime.value = new Date().toLocaleTimeString({ timeStyle: 'short' });

const display = () => {
  const now = Date.now();
  const difference = Math.floor((endDate - now) / divideTimeBy);

  if (difference < 0) countdown.innerText = 'Done!';
  else {
    countdown.innerText = difference.toString().replace(/...(?=(...)*$)/g, splitChar + '$&'); // https://stackoverflow.com/a/47644519
  }

  requestAnimationFrame(display);
};

const toggleFontSize = (number) => {
  countdown.style.fontSize = +countdown.style.fontSize.split('rem')[0] + number + 'rem';
};
const toggleSpaces = () => {
  splitChar = splitChar === ' ' ? '' : ' ';
};
const toggleSeconds = () => {
  divideTimeBy = divideTimeBy === 1 ? 1000 : 1;
};
const toggleFont = () => {
  countdown.classList.toggle('monospace');
};
const toggleDarkMode = () => {
  document.body.classList.toggle('dark');
};
const setCustomDate = () => {
  endDate = new Date(`${customDate.value} ${customTime.value}`);
};

document.addEventListener('dblclick', (e) => {
  if (e.target.tagName === 'BUTTON' || e.target.tagName === 'INPUT') return;
  menu.style.display = menu.style.display === 'flex' ? 'none' : 'flex';
});

requestAnimationFrame(display);

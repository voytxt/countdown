const countdown = document.getElementById('countdown');
const menu = document.getElementById('menu');

let endDate = new Date('June 30 2021 15:00');
let divideTimeBy = 1;
let splitChar = ' ';

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
const toggleSeconds = () => {
  divideTimeBy = divideTimeBy === 1 ? 1000 : 1;
};
const toggleSpaces = () => {
  splitChar = splitChar === ' ' ? '' : ' ';
};
const setCustomDate = () => {
  const customDate = new Date(prompt(`Set a custom date (e.g. June 6 2021 15:24)\nCurrent date is ${endDate.toDateString()}`));
  if (!isNaN(customDate) && customDate !== '') endDate = customDate;
  else alert('The date was not valid');
};

document.addEventListener('dblclick', (e) => {
  if (e.target.tagName === 'BUTTON') return;
  menu.style.display = menu.style.display === 'none' ? 'flex' : 'none';
});

requestAnimationFrame(display);

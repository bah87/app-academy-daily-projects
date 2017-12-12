const View = require('./ttt-view.js'); // require appropriate file
const Game = require('../solution/game.js'); // require appropriate file

$( () => {
  // Your code here
  window.$ = $;
  game = new Game();
  view = new View(game, $('.ttt'));
  view.setupBoard();
  view.bindEvents();
});

const Game = require("./game.js");
const GameView = require("./game_view.js");

document.addEventListener("DOMContentLoaded", function () {
  const canvas = document.getElementById('game-canvas');
  const game = new Game();
  canvas.width = Game.DIM_X;
  canvas.height = Game.DIM_Y;
  
  const ctx = canvas.getContext("2d");
  // debugger
  // ctx.clearRect(0, 0, window.innerWidth, window.innerHeight);
  // ctx.beginPath();
  // ctx.arc(10, 10, 50, 0, Math.PI * 2);
  // ctx.fillStyle = "#00FF00";
  // ctx.fill();
  new GameView(game, ctx).start();
});
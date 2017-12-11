const Asteroid = require("./asteroid.js");

function Game() {
  Game.DIM_X = 300;
  Game.DIM_Y = 300;
  
  Game.NUM_ASTEROIDS = 3;
  
  this.asteroids = this.addAsteroids();
}

Game.prototype.randomPosition = function () {
  const xPos = Math.floor(Math.random() * (Game.DIM_X));
  const yPos = Math.floor(Math.random() * (Game.DIM_Y));
  return [xPos, yPos];
};

Game.prototype.addAsteroids = function () {
  const asteroids = [];
  for (let i = 0; i < Game.NUM_ASTEROIDS; i++) {
    asteroids.push(new Asteroid({ pos: this.randomPosition() }));
  }
  return asteroids;
};

Game.prototype.draw = function (ctx) {
  ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
  for (let i = 0; i < this.asteroids.length; i++) {
    this.asteroids[i].draw(ctx);
  }
};

Game.prototype.moveObjects = function () {

  for (let i = 0; i < this.asteroids.length; i++) {
    this.asteroids[i].move();
  }
};

module.exports = Game;
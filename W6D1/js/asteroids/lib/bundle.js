/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const Game = __webpack_require__(1);
const GameView = __webpack_require__(2);

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

/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const Asteroid = __webpack_require__(3);

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

/***/ }),
/* 2 */
/***/ (function(module, exports) {



function GameView(game, ctx) {
  this.game = game;
  this.ctx = ctx;
}

GameView.prototype.start = function () {
  setInterval(() => {
    this.game.moveObjects();
    this.game.draw(this.ctx);
  }, 20);
};

module.exports = GameView;

/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const Util = __webpack_require__(4);
const MovingObject = __webpack_require__(5);

function Asteroid(optionsObj) {
  Asteroid.RADIUS = 10;
  Asteroid.COLOR = "#555";
  
  MovingObject.call(this, 
    { 
      pos: optionsObj.pos, 
      vel: Util.randomVec(5), 
      radius: Asteroid.RADIUS, 
      color: Asteroid.COLOR
    }
  );
}

Util.inherits(Asteroid, MovingObject);

module.exports = Asteroid;

/***/ }),
/* 4 */
/***/ (function(module, exports) {

const Util = {
  inherits (childClass, parentClass) {
    // childClass.prototype = Object.create(parentClass);
    function Surrogate() {}
    Surrogate.prototype = parentClass.prototype;
    childClass.prototype = new Surrogate();
    // childClass.prototype.constructor = childClass;
  },
  
  // Return a randomly oriented vector with the given length.
  randomVec (length) {
    const deg = 2 * Math.PI * Math.random();
    return Util.scale([Math.sin(deg), Math.cos(deg)], length);
  },
  
  // Scale the length of a vector by the given amount.
  scale (vec, m) {
    return [vec[0] * m, vec[1] * m];
  },
  
  dist (posStart, posEnd) {
    return Math.sqrt(Math.pow((pos1[0] - pos2[0]), 2) + Math.pow((pos1[1] - pos2[1]), 2));
  },
  
  norm (pos) {
    return Util.dist([0, 0], pos);
  } 
    
};

module.exports = Util;

/***/ }),
/* 5 */
/***/ (function(module, exports) {

function MovingObject(optionsObj) {
  this.pos = optionsObj.pos;
  this.vel = optionsObj.vel;
  this.radius = optionsObj.radius;
  this.color = optionsObj.color;
}

MovingObject.prototype.draw = function (ctx) {
  ctx.beginPath();
  ctx.arc(this.pos[0], this.pos[1], this.radius, 0, Math.PI * 2);
  ctx.fillStyle = this.color;
  ctx.fill();
};

MovingObject.prototype.move = function () {
  this.pos[0] += this.vel[0];
  this.pos[1] += this.vel[1];
};

const mo = new MovingObject(
  { pos: [30, 30], vel: [10, 10], radius: 20, color: "#00FF00" }
);

module.exports = MovingObject;


/***/ })
/******/ ]);
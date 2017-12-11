

// Function.prototype.inherits = function (superClass) {
//   function Surrogate() {}
//   Surrogate.prototype = superClass.prototype;
//   this.prototype = new Surrogate();
//   this.prototype.constructor = this;
// };
Function.prototype.inherits = function (superClass) {
  this.prototype = Object.create(superClass.prototype);
  this.prototype.constructor = this;
};

function MovingObject (name) {
  this.name = name;
}

MovingObject.prototype.move = function () {
  console.log(`${this.name} is moving!`);
};

function Ship (name) {
  MovingObject.call(this, name);
}
Ship.inherits(MovingObject);
Ship.prototype.shoot = function () {
  console.log(`${this.name} is shooting asteroids!`);
};

function Asteroid (name) {
  MovingObject.call(this, name);
}
Asteroid.inherits(MovingObject);
Asteroid.prototype.destroyed = function () {
  console.log(`${this.name} has been destroyed!`);
};

const ship = new Ship('ship');
const asteroid = new Asteroid('asteroid');  
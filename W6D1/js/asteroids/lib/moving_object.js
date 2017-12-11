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

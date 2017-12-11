const Util = require('./utils.js');
const MovingObject = require('./moving_object.js');

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
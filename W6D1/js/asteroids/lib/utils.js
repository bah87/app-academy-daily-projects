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
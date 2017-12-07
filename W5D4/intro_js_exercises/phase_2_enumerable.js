//myEach 
Array.prototype.myEach = function (callback) {
  for(i = 0; i < this.length; i++) {
    callback(this[i]);
  }
};

const print = function (el) {
  console.log(el);
};


//myMap
Array.prototype.myMap = function (callback) {
  const mapped = [];
  this.myEach(function(el) {
    mapped.push(callback(el));
  }); 
  return mapped;
};

const timesTwo = function (num) {
   return num * 2;
};


// myReduce
Array.prototype.myReduce = function (callback, acc) {
  let toReduce = this;
  
  if (acc === undefined) {
    acc = toReduce[0];
    toReduce = this.slice(1);
  }
  
  toReduce.myEach(function (el) {
    acc = callback(acc, el);
  });
  
  return acc;
};

const sum = function (num1, num2) {
  return num1 + num2;
};

const product = function (num1, num2) {
  return num1 * num2;
};
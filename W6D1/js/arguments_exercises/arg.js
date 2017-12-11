//SUM:
// function sum() {
//   const numbers = Array.from(arguments);
//   return numbers.reduce((acc, el) => (acc + el));
// }

function sumArgs(...args) {
  return args.reduce((acc, el) => (acc + el));
}

//BIND with args:

Function.prototype.myBind = function(ctx) {
  const bindArgs = Array.from(arguments).slice(1);
  const functionCallback = this;
  return function() {
    const callArgs = Array.from(arguments);
    return functionCallback.apply(ctx, bindArgs.concat(callArgs));
  };
};

Function.prototype.myBindRest = function(ctx, ...bindArgs) {
  return (...callArgs) => (
    this.apply(ctx, bindArgs.concat(callArgs))
  );
};

class Cat {
  constructor(name) {
    this.name = name;
  }

  says(sound, person) {
    console.log(`${this.name} says ${sound} to ${person}!`);
    return true;
  }
}

const markov = new Cat("Markov");
const breakfast = new Cat("Breakfast");

// curriedSum
function curriedSum(numArgs) {
  const numbers = [];
  function _curriedSum(num) {
    numbers.push(num);  
    
    if (numbers.length === numArgs) {
      return numbers.reduce( (acc, el) => (acc + el));
    } else {
      return _curriedSum;
    }
  }
  return _curriedSum;
}

Function.prototype.curry = function (numArgs) {
  const args = [];
  const _curry = (arg) => {
    args.push(arg);
    if (args.length === numArgs) {
      return this.apply(null, args);
    } else {
      return _curry;
    }
  };
  return _curry;
};


Function.prototype.curryRest = function (numArgs) {
  const _curry = (...args) => {
    if (args.length === numArgs) {
      return this.apply(null, args);
    } else {
      return _curry;
    }
  };
  return _curry;
};

Function.prototype.currybest = function (numArgs) {
  const _curry = (...args) => ( (args.length === numArgs) ? this.apply(null, args) : _curry );
  return _curry;
};




function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

// sumThree(4, 20, 6); // == 30
// 
// // you'll write `Function#curry`!
// let f1 = sumThree.curry(3); // tells `f1` to wait until 3 arguments are given before running `sumThree`
// f1 = f1(4); // [Function]
// f1 = f1(20); // [Function]
// f1 = f1(6); // = 30

// or more briefly:
// sumThree.curry(3)(4)(20)(6); // == 30
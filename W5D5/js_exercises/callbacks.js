// Clock
class Clock {
  constructor() {
    // 1. Create a Date object.
    // 2. Store the hours, minutes, and seconds.
    // 3. Call printTime.
    // 4. Schedule the tick at 1 second intervals.
    const now = new Date();
    this.hours = now.getHours();
    this.minutes = now.getMinutes();
    this.seconds = now.getSeconds();
    this.printTime();
    setInterval(this._tick.bind(this), 1000);
  }

  printTime() {
    // Format the time in HH:MM:SS
    // Use console.log to print it.
    console.log(`${this.hours}:${this.minutes}:${this.seconds}`);
  }

  _tick() {
    // 1. Increment the time by one second.
    // 2. Call printTime.
    this.seconds++;
    this.printTime();
  }
}

// const readline = require('readline');
//
// const reader = readline.createInterface({
//   input: process.stdin,
//   output: process.stdout
// });

// addNumbers
function addNumbers(sum, numsLeft, completionCallback) {
  if (numsLeft > 0) {
    reader.question("Input a number: ", response => {
      let i = parseInt(response);
      sum += i;
      console.log(`Current sum: ${sum}`);
      numsLeft--;
      addNumbers(sum, numsLeft, completionCallback);
    });
  } else if (numsLeft === 0) {
    completionCallback(sum);
    reader.close();
  }
}

// addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));


// absurdBubbleSort
function askIfGreaterThan(el1, el2, callback) {
  reader.question(`Is ${el1} > ${el2}? (Y/N) `, (response) => {
    if (response === "Y") {
      callback(true);
    }
    else {
      callback(false);
    }
  });
}

function absurdBubbleSort(arr, sortCompletionCallback) {

  function outerBubbleSortLoop(madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    }
    else {
      sortCompletionCallback(arr);
    }
  }

  outerBubbleSortLoop(true);
}

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length - 1) {
    askIfGreaterThan(arr[i], arr[i + 1], function(isGreaterThan) {
      if (isGreaterThan) {
        [arr[i], arr[i + 1]] = [arr[i + 1], arr[i]];
        madeAnySwaps = true;
      }

      i++;
      innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop);
    });
  }
  else {
    console.log(arr);
    outerBubbleSortLoop(madeAnySwaps);
  }
}

// console.log([1,-3,16,2,3,0,5,1].absurdBubbleSort());
// innerBubbleSortLoop([1,-3,16,0,5,1], 0, false, console.log);
// console.log([1,-3,16,0,5,1].absurdBubbleSort());
// absurdBubbleSort([3, 2, 1], function (arr) {
//   console.log("Sorted array: " + JSON.stringify(arr));
//   reader.close();
// });

// myBind
// Function.prototype.myBind = function (context) {
//   const that = this;
//   return function () {
//     return that.apply(context);
//   };
// };

Function.prototype.myBind = function (context) {
  return (...args) => {
    return this.apply(context, args);
  };
};
// const bigBen = new Clock();

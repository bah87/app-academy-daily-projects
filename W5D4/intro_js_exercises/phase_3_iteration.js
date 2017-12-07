//bubbleSort
Array.prototype.bubbleSort = function (callback) {
  if (callback === undefined) {
    callback = function(input1, input2) {
      return input1 < input2;
    };
  }
  const toSort = this;
  let unsorted = true;
  while (unsorted) {
    unsorted = false;
    for(let i = 0; i < (toSort.length - 1); i++) {
      if (callback(toSort[i + 1], toSort[i])) {
        [toSort[i], toSort[i + 1]] = [toSort[i + 1], toSort[i]];
        unsorted = true;
      }
    }
  } 
  return toSort;
};

// const reverseCallback = function(input1, input2) {
//   return input2 < input1;
// };


// subStrings
String.prototype.subStrings = function () {
  let subs = [];
  for (let idx1 = 0; idx1 < this.length; idx1++) {
    for (let idx2 = (idx1 + 1); idx2 < (this.length + 1); idx2++) {
      if (!subs.includes(this.slice(idx1, idx2))) {
        subs.push(this.slice(idx1, idx2));
      }
    }
  }
  
  return subs;
};

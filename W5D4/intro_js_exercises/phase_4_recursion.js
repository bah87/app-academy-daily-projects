// range
function range (start, end) {
  if (start === end) {
    return [end];
  } else {
    return [start].concat(range((start + 1), end));
  }
}

//sumRec 
function sumRec (arr) {
  if (arr.length === 0) {
    return 0;
  } else {
    return arr[0] + sumRec(arr.slice(1));
  }
}

// exponent
function exponent (base, power) {
  if (power === 0) {
    return 1;
  } else {
    return base * exponent(base, (power - 1));
  }
}

// exponent2
function exponent2 (base, power) {
  if (power === 0) {
    return 1;
  }
  
  if (power % 2 === 0) {
    return Math.pow(exponent2(base, (power / 2)), 2);
  } else {
    return base * Math.pow(exponent2(base, ((power - 1) / 2)), 2);
  }
}

// fibonnaci
function fibonnaci (n) {
  let fibs = [0, 1];
  if (n <= 2) {
    return fibs.slice(0, n); 
  } else {
    let prevFibs = fibonnaci(n - 1);
    let lastFib = prevFibs[prevFibs.length - 1];
    let secToLastFib = prevFibs[prevFibs.length - 2];
    return prevFibs.concat([lastFib + secToLastFib]);
  }
}

//bsearch
function bsearch (arr, target) {
  if (arr.length === 0) {
    return -1;
  }
  let midindex = Math.floor(arr.length / 2);
  let mid = arr[midindex];
  let left = arr.slice(0, midindex);
  let right = arr.slice(midindex + 1, arr.length);
  if ( target < mid ) {
    return bsearch(left, target) ;
  } else if (mid === target) { 
    return midindex; 
  } else {
    let result = bsearch(right, target);
    if (result === -1) {
      return -1;
    } else {
      return result + midindex + 1;
    }
  }  
}

// mergeSort
function mergeSort(arr, callback) {
  if (callback === undefined) {
    callback = function(input1, input2) {
      return input1 <= input2;
    };
  }
  
  if (arr.length <= 1) {
    return arr;
  }
  
  let midindex = Math.floor(arr.length / 2);
  let left = arr.slice(0, midindex);
  let right = arr.slice(midindex, arr.length);
  
  function merge (left, right) {
    let sorted = [];
    while ((left.length > 0) && (right.length > 0)) {
      if (callback(left[0], right[0])) {
        sorted.push(left.shift());
      } else {
        sorted.push(right.shift());
      }
    }
    
    return sorted.concat(left.concat(right));
  }
  
  return merge(mergeSort(left, callback), mergeSort(right, callback));
}

const reverseCallback = function(input1, input2) {
  return input1 > input2;
};

//subsets 

function subsets (arr) {
  if (arr.length === 0) {
    return [[]];
  }
  let last = [arr[arr.length - 1]];
  let prevSubsets = subsets(arr.slice(0, arr.length - 1));
  let subs = [];
  prevSubsets.forEach (sub => {
    subs.push(sub.concat(last));
  });
  return prevSubsets.concat(subs);
}
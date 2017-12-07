// myUniq
Array.prototype.myUniq = function () {
  const uniques = [];
  this.forEach(function (el) {
    if (!uniques.includes(el)) {
      uniques.push(el);
    }
  });
  
  return uniques;
};

// twoSum
Array.prototype.twoSum = function () {
  const pairs = [];
  for (let i = 0; i < (this.length - 1); i++) {
    for (let j = i + 1; j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        pairs.push([i, j]);
      }
    }
  }
  
  return pairs;
};

//myTranspose
// Array.prototype.myTranspose = function () {
//   const transposed = new Array(this[0].length);
// 
//   for (let i = 0; i < transposed.length; i++) {
//     transposed[i] = new Array(this.length);
//   }
// 
//   for (let idx1 = 0; idx1 < this.length; idx1++) {
//     for (let idx2 = 0; idx2 < this.length; idx2++) {
//       transposed[idx1][idx2] = this[idx2][idx1];
//     }
//   }
// 
//   return transposed;
// };


Array.prototype.myTranspose = function () {
  const transposed = [];
  
  for (let i = 0; i < this[0].length; i++) {
    let arr = [];
    for (let j = 0; j < this.length; j++) {
      arr.push(this[j][i]);
    }
    transposed.push(arr);
  }
  
  return transposed;
};

// const arr1 = [[1,3],[2,4]];
// const arr2 = [[1,3,5],[2,4,6]];
// const arr3 = [[1,3],[2,4],[5,6],[7,8]];

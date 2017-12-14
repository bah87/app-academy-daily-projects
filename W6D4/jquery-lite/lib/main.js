const DOMNodeCollection = require('./dom_node_collection.js');

const $l = (...selectorOrHTMLOrFns) => {
  let nodeArr = [];
  
  if (selectorOrHTMLOrFns[0] instanceof HTMLElement) {
    nodeArr.push(selectorOrHTMLOrFns[0]);
  } 
  
  else if (typeof selectorOrHTMLOrFns[0] === "function") {
    document.addEventListener("DOMContentLoaded", function() {
      selectorOrHTMLOrFns.forEach( (fn) => {
        fn();
      });
    });
  } 
  
  else {
    let elementList = document.querySelectorAll(selectorOrHTMLOrFns[0]);
    
    for (let i = 0; i < elementList.length; i++) {
      nodeArr.push(elementList[i]);
    }
  }
  
  return new DOMNodeCollection(nodeArr);
};

$l.extend = (...objects) => {
  return Object.assign(...objects);
};

$l.ajax = (options) => {
  let defaults = { 
    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
    dataType: 'JSON',
    method: 'GET',
    data: {},
    success: (data) => {
              console.log("Success!");
              console.log(data);
            },
    error: () => {
            console.error("An error occurred.");
          },
    url: window.location.href
  };
  
  options = $.extend(defaults, options);
  
  const xhr = new XMLHttpRequest();

  xhr.open(options.method, options.url);

  xhr.onload = function () {
    console.log(xhr.status); 
    console.log(xhr.responseType); 
    console.log(xhr.response); 
  };

  xhr.send();
};

window.$l = $l;
$l(() => alert("1"), () => alert("2"));
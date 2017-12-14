const DOMNodeCollection = require('./dom_node_collection.js');

$l = (selectorOrHTML) => {
  let nodeArr = [];
  
  if (selectorOrHTML instanceof HTMLElement) {
    nodeArr.push(selectorOrHTML);
  } else {
    let elementList = document.querySelectorAll(selectorOrHTML);
    
    for (let i = 0; i < elementList.length; i++) {
      nodeArr.push(elementList[i]);
    }
  }
  
  return new DOMNodeCollection(nodeArr);
};

window.$l = $l;
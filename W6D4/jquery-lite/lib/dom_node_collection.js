class DOMNodeCollection {
  constructor (HTMLElements) {
    this.elements = HTMLElements;
  }
  
  html (string) {
    if (string === undefined) {
      return this.elements[0].innerHTML;
    } else {
      this.elements.forEach( (el) => {
        el.innerHTML = string;
      });
    }
  }
  
  empty () {
    this.html("");
  }
  
  append (strOrCollection) {
    if (strOrCollection.constructor.name === "String") {
      this.elements.forEach( (el) => {
        el.innerHTML += strOrCollection;
      }); 
    } else {
      this.elements.forEach( (outerEl) => {
        strOrCollection.elements.forEach( (appended) => {
          outerEl.innerHTML += appended.outerHTML;
        });
      });
    }
  }
  
  attr (name, value) {
    if (value === undefined) {
      return this.elements[0].getAttribute(name);
    } else {
      this.elements.forEach( (attribute) => {
        attribute.setAttribute(name, value);
      });
    }
  }
  
  addClass (className) {
    this.elements.forEach( (el) => {
      el.className = className;
    });
  }
  
  removeClass () {
    this.elements.forEach( (el) => {
      el.className = "";
    });
  }
  
  children () {
    let children = [];
    this.elements.forEach( (el) => {
      for (let i = 0; i < el.children.length; i++) {
        children.push(el.children[i]);
      }
    });
    
    return new DOMNodeCollection(children);
  }
  
  parent () {
    let parents = [];
    this.elements.forEach( (el) => {
      parents.push(el.parentElement);
    });
    
    return new DOMNodeCollection(parents);
  }
  
  find (selector) {
    let found = [];
    let oneQuery;
    
    this.elements.forEach( (el) => {
      oneQuery = el.querySelectorAll(selector);
      for (let i = 0; i < oneQuery.length; i++) {
        found.push(oneQuery[i]);
      }
    });
    
    return found;
  }
  
  remove () {
    let removed = this.elements;
    
    this.empty();
    this.elements.forEach( (el) => {
      el.outerHTML = "";
    });
    
    this.elements = [];
    return removed;
  }
  
  on (type, callback) {
    this.elements.forEach( (el) => {
      el.addEventListener(type, callback);
      el.callbackFn = callback;
    });
  }
  
  off (type) {
    this.elements.forEach( (el) => {
      el.removeEventListener(type, el.callbackFn);
    });
  }
}

module.exports = DOMNodeCollection;
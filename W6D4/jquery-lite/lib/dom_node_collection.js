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
  
  attr () {
    
  }
  
  addClass () {
    
  }
  
  removeClass () {
    
  }
  
  children () {
    
  }
  
  parent () {
    
  }
  
  find () {
    
  }
  
  remove () {
    
  }
}

module.exports = DOMNodeCollection;
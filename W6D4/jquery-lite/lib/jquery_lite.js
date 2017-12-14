/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const DOMNodeCollection = __webpack_require__(1);

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

/***/ }),
/* 1 */
/***/ (function(module, exports) {

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
    this.empty();
    let removed = this.elements;
    this.elements = [];
    return removed;
  }
}

module.exports = DOMNodeCollection;

/***/ })
/******/ ]);
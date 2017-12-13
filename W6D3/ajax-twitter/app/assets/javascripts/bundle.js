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

const FollowToggle = __webpack_require__(1);
const UsersSearch = __webpack_require__(4);

$( () => {
  window.$ = $;
  // const buttonEls = $('.follow-toggle');
  // buttonEls.each((idx, button) => {
  //   new FollowToggle(button);
  // });
  
  const users = $('.users-search');
  new UsersSearch(users)
});

/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(3);

class FollowToggle {
  constructor ($el, options) {
    this.$el = $el;
    // this.$el = $(el);
    this.userId = this.$el.data("user-id") || options.userId;
    this.followState = (this.$el.data("initial-follow-state") ||
                        options.followState);
    this.render();
    
    this.$el.on('click', this.handleClick.bind(this));
  }
  
  render () {
    switch (this.followState) {
      case "unfollowed":
        this.$el.text("Follow!");
        this.$el.prop("disabled", false);
        break;
      case "followed":
        this.$el.text("Unfollow!");
        this.$el.prop("disabled", false);
        break;
      case "unfollowing":
        this.$el.text("Unfollowing...");
        this.$el.prop("disabled", true);
        break;
      case "following":
        this.$el.text("Following...");
        this.$el.prop("disabled", true);
        break;
    }
  }
  
  handleClick (event) {    
    event.preventDefault();
    
    this.followState = (this.followState === "followed") ? "unfollowing" : "following";
    this.render();    
    
    let success = () => {
      this.followState = (this.followState === "following") ? "followed" : "unfollowed";
      this.render();
    };
    
    let failure = () => {
      alert("something went wrong!!!");
    };
    
    
    if (this.followState === "unfollowing") {
      APIUtil.unfollowUser(this.userId).then(success, failure);
    } else if (this.followState === "following") {
      APIUtil.followUser(this.userId).then(success, failure);
    }
    
  }
}

module.exports = FollowToggle;

/***/ }),
/* 2 */,
/* 3 */
/***/ (function(module, exports) {

const APIUtil = {
  followUser: id => {
    return $.ajax({
      url: `/users/${id}/follow`,
			type: 'POST',
			dataType: 'JSON'
    });
  },

  unfollowUser: id => {
    return $.ajax({
      url: `/users/${id}/follow`,
			type: 'DELETE',
			dataType: 'JSON'
    });
  },
  
  searchUsers: (queryVal, success) => {
    return $.ajax({
      url: '/users/search',
      dataType: 'JSON',
      data: { query: queryVal },
      success: response => {
        success(response);
      }
    });
  }
};

module.exports = APIUtil;

/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(3);
const FollowToggle = __webpack_require__(1);

class UsersSearch {
  constructor ($el) {
    this.$el = $el;
    this.input = $(this.$el.children()[0]);
    this.ul = $(this.$el.children()[1]);
    
    this.input.on('input', this.handleInput.bind(this));
  }
  
  handleInput (event) {
    let failure = () => {
      alert("something went wrong!!!");
    };
    
    APIUtil.searchUsers(event.target.value, this.renderResults.bind(this));
  }
  
  renderResults (response) {
    let follow;
    
    $('li').remove();
    response.forEach((user) => {
      
      this.ul.append(`<li>@${user.username}</li>`);
      
      $('li').last().append(`<button type="button" name="button" class="follow-toggle"></button>`);
      
      follow = new FollowToggle($('.follow-toggle').last(), { userId: user.id, followState: "unfollowed" });
      
      follow.render();
    });
  }
}

module.exports = UsersSearch;

/***/ })
/******/ ]);
//# sourceMappingURL=bundle.js.map
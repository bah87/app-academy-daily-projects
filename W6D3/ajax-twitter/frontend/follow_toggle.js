const APIUtil = require('./api_util.js');

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
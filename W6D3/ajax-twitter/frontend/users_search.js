const APIUtil = require('./api_util.js');
const FollowToggle = require('./follow_toggle.js');

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
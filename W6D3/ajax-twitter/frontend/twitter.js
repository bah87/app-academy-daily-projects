const FollowToggle = require('./follow_toggle.js');
const UsersSearch = require('./users_search.js');

$( () => {
  window.$ = $;
  // const buttonEls = $('.follow-toggle');
  // buttonEls.each((idx, button) => {
  //   new FollowToggle(button);
  // });
  
  const users = $('.users-search');
  new UsersSearch(users)
});
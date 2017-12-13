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
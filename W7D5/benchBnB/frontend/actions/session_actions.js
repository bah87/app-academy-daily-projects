import * as APIUtil from '../util/session_api_util';

export const RECEIVE_CURRENT_USER = 'RECEIVE_CURRENT_USER';
export const RECEIVE_SESSION_ERRORS = 'RECEIVE_SESSION_ERRORS';

export const receiveCurrentUser = currentUser => {
  return {
    type: RECEIVE_CURRENT_USER,
    currentUser
  };
};

export const receiveErrors = errors => {
  return {
    type: RECEIVE_SESSION_ERRORS,
    errors
  };
};

export const login = user => dispatch => {
  return APIUtil.login(user).then(returnedUser => (
    dispatch(receiveCurrentUser(returnedUser))
  ), err => (
    dispatch(receiveErrors(err.responseJSON))
  ));
};

export const signup = user => dispatch => {
  return APIUtil.signup(user).then(returnedUser => (
    dispatch(receiveCurrentUser(returnedUser))
  ), err => (
    dispatch(receiveErrors(err.responseJSON))
  ));
};

export const logout = () => dispatch => {
  return APIUtil.logout().then( () => (
    dispatch(receiveCurrentUser(null))
  ));
};

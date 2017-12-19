import { RECEIVE_ERRORS, CLEAR_ERRORS } from '../actions/error_actions';

const errorsReducer = (state = [], action) => {
  Object.freeze(state);
  let nextState;

  switch(action.type) {
    case RECEIVE_ERRORS:
    debugger
      nextState = action.errors;
      return nextState;
    case CLEAR_ERRORS:
      nextState = [];
      return nextState;
    default:
      return state;
  }
};

export default errorsReducer;

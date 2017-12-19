import React from 'react';
import ReactDOM from 'react-dom';
import { receiveTodo, receiveTodos } from './actions/todo_actions';
import App from './components/app';
import Root from './components/root';
import allTodos from './reducers/selectors';
import uniqueId from './util/util';

import configureStore from './store/store';
window.store = configureStore();
window.receiveTodo = receiveTodo;
window.receiveTodos = receiveTodos;
window.allTodos = allTodos;
window.uniqueId = uniqueId; 

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(<Root store={configureStore()}/>, document.getElementById("root"));
});

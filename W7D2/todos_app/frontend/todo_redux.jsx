import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import * as TodoAPIUtil from './util/todo_api_util';
import Root from './components/root';
import { fetchTodos } from './actions/todo_actions';

// window.fetchTodos = fetchTodos;

const preloadedState = localStorage.state ?
  JSON.parse(localStorage.state) : {};
const store = configureStore(preloadedState);

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('content');
  ReactDOM.render(<Root store={store} />, root);
});

window.store = store; 

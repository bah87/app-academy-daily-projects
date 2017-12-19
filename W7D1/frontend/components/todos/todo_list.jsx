import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form'

const TodoList = ({todos, receiveTodo}) => {
  const todoListItems = todos.map((todo, idx) => (
    <TodoListItem key={idx} title={todo.title}/>
  ))
  return (
    <div>
      <ul>
        {todoListItems}
      </ul>
      <TodoForm receiveTodo={receiveTodo}/>
    </div>

  )
};

export default TodoList;

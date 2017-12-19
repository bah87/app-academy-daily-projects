import React from 'react';

const TodoListItem = ({idx, title}) => {
  return (
    <li key={idx}>{title}</li>
  );
};

export default TodoListItem;

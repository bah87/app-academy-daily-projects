import React from 'react';
// Components
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

class TodoList extends React.Component {

  componentDidMount() {
    this.props.fetchTodos();
  }

  render() {
    const todoListItems = this.props.todos.map((todo, idx) => (
      <TodoListItem key={idx} title={todo.title}/>
    ));
    return (
      <div>
        <ul>
          {todoListItems}
        </ul>
        <h2>{this.props.state.errors}</h2>
        <TodoForm errors={this.props.state.errors} createTodo={this.props.createTodo}/>
      </div>

    );
  }
}

export default TodoList;

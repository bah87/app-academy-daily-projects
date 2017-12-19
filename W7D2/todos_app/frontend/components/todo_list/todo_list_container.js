import { connect } from 'react-redux';
import TodoList from './todo_list';

// Actions
import { receiveTodos, createTodo, fetchTodos } from '../../actions/todo_actions';
import { clearErrors } from '../../actions/error_actions';
import { allTodos } from '../../reducers/selectors';

const mapStateToProps = state => ({
  todos: allTodos(state),
  state
});

const mapDispatchToProps = dispatch => ({
  receiveTodos: () => dispatch(receiveTodos()),
  createTodo: todo => dispatch(createTodo(todo)),
  fetchTodos: () => dispatch(fetchTodos()),
  clearErrors: () => dispatch(clearErrors())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);

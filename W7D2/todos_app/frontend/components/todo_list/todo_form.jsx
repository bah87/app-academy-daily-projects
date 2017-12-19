import { uniqueId } from '../../util/id_generator';
import React from 'react';

class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = { title: "", body: "" };
    this.handleBody = this.handleBody.bind(this);
    this.handleTitle = this.handleTitle.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(event) {
    event.preventDefault();
    const todo = {title: this.state.title, body: this.state.body };
    this.props.createTodo(todo).then(
      () => this.setState({title: "", body: ""})
    );
  }

  handleBody(event) {
    this.setState({body: event.target.value});
  }

  handleTitle(event) {
    this.setState({title: event.target.value});
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>Title
          <input type="text" value={this.state.title} onChange={this.handleTitle}/>
        </label>

        <label>Body
          <input type="text" value={this.state.body} onChange={this.handleBody}/>
        </label>

        <input type="submit" value="Create Todo!"/>
      </form>
    );
  }
}

export default TodoForm;

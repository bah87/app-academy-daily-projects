import React from 'react';
import uniqueId from '../../util/util';

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
    this.props.receiveTodo({id: uniqueId(),
                            title: this.state.title,
                            body: this.state.body
    });
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
        <input type="text" value={this.state.title} onChange={this.handleTitle}/>
        <input type="text" value={this.state.body} onChange={this.handleBody}/>
        <input type="submit" value="Add Item"/>
      </form>
    );
  }
}

export default TodoForm;

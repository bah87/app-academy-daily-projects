import React from 'react';
import TabItem from './tab_item';

class Tabs extends React.Component {
  constructor (props) {
    super(props);
    this.state = { selectedId: 0 };
    this.tabs = this.props.tabs;
    this.updateId = this.updateId.bind(this);
  }

  updateId (id) {
    return (event) => {
      this.setState({ selectedId: id });
    };
  }

  render () {

    const tabs = this.tabs.map((tab, idx) => {
      return (
        <TabItem
          tab={ tab }
          key={ idx }
          id={ idx }
          selectedId={ this.state.selectedId }
          updateId={ this.updateId }
        />
      );
    });

    return (
      <div className="tab">
        <ul className='tab-header'>
          { tabs }
        </ul>
        <article className='tab-content'>
          { this.tabs[this.state.selectedId].content }
        </article>
      </div>
    );
  }
}

export default Tabs;

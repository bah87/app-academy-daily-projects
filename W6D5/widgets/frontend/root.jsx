import React from 'react';
import Clock from './clock';
import Tabs from './tabs';

class Root extends React.Component {
  constructor (props) {
    super(props);
  }

  render () {
    return (
      <main className="widgets">

        <div>
          <Clock/>
        </div>

        <div className="lower-widgets">
          <div>
            <Tabs tabs={[
                {title: "first", content: "I am 1st"},
                {title: "second", content: "I am 2nd"},
                {title: "third", content: "I am 3rd"}
              ]}
              />
          </div>
          <div>

          </div>
        </div>

      </main>
    );
  }
}

export default Root;

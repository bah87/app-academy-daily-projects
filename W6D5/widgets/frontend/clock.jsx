import React from 'react';

class Clock extends React.Component {
  constructor(props) {
    super(props);
    this.title = "BigBen";
    this.state = { date: new Date() };
    this.tick = this.tick.bind(this);

  }

  render () {
    const { date } = this.state;
    const hours = date.getHours();
    const minutes = date.getMinutes();
    const seconds = date.getSeconds();

    return (
      <div className="clock-wrapper">
        <h1>Clock</h1>
          <div className="clock">
            <div className="time">
              <h2>Time:</h2>
              <h2>
                { hours < 10 ? "0" + hours : hours}:
                { minutes < 10 ? "0" + minutes : minutes}:
                { seconds < 10 ? "0" + seconds : seconds}
              </h2>
            </div>
            <div className="date">
              <h2>Date:</h2>
              <h2>
                { date.toString().slice(0,15) }
              </h2>
            </div>
          </div>
      </div>
    );
  }

  tick () {
    const date = new Date();
    this.setState({ date });
  }

  componentDidMount() {
    this.handle = setInterval(this.tick, 1000);
  }

  componentWillUnmount() {
    clearInterval(this.handle);

  }
}

export default Clock;

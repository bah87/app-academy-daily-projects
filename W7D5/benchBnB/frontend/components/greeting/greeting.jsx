import React from 'react';
import { Link } from 'react-router-dom';

const sessionLinks = () => (
  <nav>
    <Link to="/login">Login</Link>
    <Link to="/signup">Signup</Link>
  </nav>
);

const personalGreeting = (currentUser, logout) => (
  <div>
    <h3>Welcome, {currentUser.username}!</h3>
    <button onClick={logout}>Logout</button>
  </div>
);

const Greeting = ({ currentUser, logout }) => (
  currentUser ? personalGreeting(currentUser, logout) : sessionLinks()
);

export default Greeting;

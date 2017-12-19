const path = require("path");

module.exports = {
  context: __dirname,
  entry: path.join(__dirname, "frontend", "todo_redux.jsx"),
  // entry: './frontend/todo_redux.jsx',
  output: {
    // path: path.resolve(__dirname),
    // filename: 'bundle.js'
    path: path.join(__dirname, "app", "assets", "javascripts"),
    filename: "bundle.js"
  },
  module: {
    loaders: [
      {
        test: [/\.jsx?$/],
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['env', 'react']
        }
      }
    ]
  },
  devtool: 'source-map',
  resolve: {
    extensions: ['.js', '.jsx', '*']
  }
};

// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from '../css/app.css'

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import 'phoenix_html'

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import React from 'react'
import ReactDOM from 'react-dom'

const Hello = function() {
  return (
    <h1>React is working!</h1>
  )
}

// This code starts up the React app when it runs in a browser injects the app into a DOM element.
ReactDOM.render(<Hello />, document.getElementById('app'))
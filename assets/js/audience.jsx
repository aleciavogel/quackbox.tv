// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import 'phoenix_html'

import React from 'react'
import ReactDOM from 'react-dom'
import AudienceApp from './audience/App'

// This code starts up the React app when it runs in a browser injects the app into a DOM element.
ReactDOM.render(<AudienceApp />, document.getElementById('app'))
// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import 'phoenix_html'

import { Socket } from 'phoenix'
import React from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'react-redux'

import configureStore from './host/store'
import HostApp from './host/App'

const store = configureStore()
const token = window.hostToken
const room_id = window.roomID

let socket = new Socket(
  "/socket", 
  {
    params: {
      host_token: token,
      access_code: room_id
    }
  }
)

ReactDOM.render(
  <Provider store={store}>
    <HostApp socket={socket} room_id={room_id} />
  </Provider>,
  document.getElementById('app')
)
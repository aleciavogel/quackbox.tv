import "phoenix_html";

import { Socket } from "phoenix";
import React from "react";
import ReactDOM from "react-dom";
import { Provider } from "react-redux";

import configureStore from "./player/store";
import PlayerApp from "./player/App";

const store = configureStore();
const token = window.playerToken;
const room_id = window.roomID;

let socket = new Socket("/socket", {
  params: {
    player_token: token,
    access_code: room_id
  }
});

ReactDOM.render(
  <Provider store={store}>
    <PlayerApp socket={socket} room_id={room_id} />
  </Provider>,
  document.getElementById("app")
);

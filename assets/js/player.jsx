import "phoenix_html";

import { Socket } from "phoenix";
import React from "react";
import ReactDOM from "react-dom";
import { Provider } from "react-redux";

import configureStore from "./player/store";
import PlayerApp from "./player/App";
import Layout from "./common/Layout";

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
    <Layout>
      <PlayerApp socket={socket} room_id={room_id} />
    </Layout>
  </Provider>,
  document.getElementById("app")
);

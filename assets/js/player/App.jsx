import React, { Component } from "react";
import { connect } from "react-redux";

import { joinRoom } from "./actions";
import GameStart from "./scenes/GameStart";

class App extends Component {
  componentDidMount() {
    const { dispatch, socket, room_id } = this.props;
    socket.connect();
    dispatch(joinRoom(socket, room_id));
  }

  render() {
    const { loading } = this.props;

    if (loading) {
      return <div>Loading...</div>;
    }

    return <GameStart />;
  }
}

function mapStateToProps(state) {
  const { loading } = state;

  return {
    loading
  };
}

export default connect(mapStateToProps)(App);

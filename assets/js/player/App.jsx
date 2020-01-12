import React, { Component } from "react";
import { connect } from "react-redux";

import { joinRoom } from "./actions";
import GameStart from "./scenes/GameStart";
import SelectCategory from "./scenes/SelectCategory";
import Loading from "../common/Loading";
import Switch from "../common/Switch";

class App extends Component {
  componentDidMount() {
    const { dispatch, socket, room_id } = this.props;
    socket.connect();
    dispatch(joinRoom(socket, room_id));
  }

  render() {
    const { loading } = this.props;

    if (loading) {
      return <Loading />;
    }

    return (
      <Switch>
        <GameStart scene="game-start" />
        <SelectCategory scene="select-category" />
        {/* TODO: answering */}
        {/* TODO: voting */}
        {/* TODO: leaderboard */}
        {/* TODO: game-end */}
      </Switch>
    );
  }
}

function mapStateToProps(state) {
  const { loading } = state;

  return {
    loading
  };
}

export default connect(mapStateToProps)(App);

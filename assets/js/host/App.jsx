import React, { Component } from "react";
import { compose } from "redux";
import { connect } from "react-redux";
import { withStyles } from "@material-ui/core/styles";
import Grid from "@material-ui/core/Grid";

import { joinRoom } from "./actions";
import { RoomCode, AudienceCounter } from "./components/Layout";

import GameStart from "./scenes/GameStart";
import SelectCategory from "./scenes/SelectCategory";
import Loading from "../common/Loading";
import Switch from "../common/Switch";

const styles = {
  root: {
    height: "100vh"
  }
};

class App extends Component {
  componentDidMount() {
    const { dispatch, socket, room_id } = this.props;
    socket.connect();
    dispatch(joinRoom(socket, room_id));
  }

  render() {
    const { loading, classes, room_id } = this.props;

    if (loading) {
      return <Loading />;
    }

    return (
      <Grid container className={classes.root}>
        <Switch>
          <GameStart scene="game-start" />
          <SelectCategory scene="select-category" />
          {/* TODO: answering */}
          {/* TODO: voting */}
          {/* TODO: leaderboard */}
          {/* TODO: game-end */}
        </Switch>
        <RoomCode room_id={room_id} />
        <AudienceCounter />
      </Grid>
    );
  }
}

function mapStateToProps(state) {
  const { loading } = state;

  return {
    loading
  };
}

export default compose(connect(mapStateToProps), withStyles(styles))(App);

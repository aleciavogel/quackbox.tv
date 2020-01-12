import React from "react";
import { connect } from "react-redux";
import { makeStyles } from "@material-ui/core/styles";
import Box from "@material-ui/core/Box";
import Typography from "@material-ui/core/Typography";

import PlayerListItem from "./PlayerListItem";

const useStyles = makeStyles(theme => ({
  root: {
    paddingTop: theme.spacing(2),
    paddingBottom: theme.spacing(2)
  }
}));

const PlayerList = ({ players }) => {
  const classes = useStyles();
  const player_items = players.map(player => (
    <PlayerListItem player={player} key={player.id} />
  ));

  return (
    <Box className={classes.root}>
      <Typography variant="subtitle1" color="textSecondary" gutterBottom>
        Players
      </Typography>

      {player_items}
    </Box>
  );
};

function mapStateToProps(state) {
  const { players } = state;
  return {
    players
  };
}

export default connect(mapStateToProps)(PlayerList);

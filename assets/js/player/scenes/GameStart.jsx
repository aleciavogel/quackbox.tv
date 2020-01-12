import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import { connect } from "react-redux";
import Box from "@material-ui/core/Box";
import Typography from "@material-ui/core/Typography";
import Button from "@material-ui/core/Button";

import { startGame } from "../actions";

const useStyles = makeStyles(theme => ({
  playerName: {
    textTransform: "capitalize"
  },
  centeredText: {
    textAlign: "center"
  },
  button: {
    marginTop: theme.spacing(3)
  }
}));

const GameStart = ({ player, dispatch, channel }) => {
  const classes = useStyles();

  return (
    <Box className={classes.centeredText}>
      <Typography variant="h5" gutterBottom>
        Welcome <span className={classes.playerName}>{player.name}!</span>
      </Typography>

      {player.is_lead && (
        <>
          <Typography variant="body1">
            Press the button below when you're ready to start the game
          </Typography>

          <Button
            variant="contained"
            className={classes.button}
            onClick={() => dispatch(startGame(channel))}
          >
            Everybody's In
          </Button>
        </>
      )}

      {!player.is_lead && (
        <Typography variant="body1">Waiting for more players...</Typography>
      )}
    </Box>
  );
};

function mapStateToProps(state) {
  const { player, channel } = state;

  return {
    player,
    channel
  };
}

export default connect(mapStateToProps)(GameStart);

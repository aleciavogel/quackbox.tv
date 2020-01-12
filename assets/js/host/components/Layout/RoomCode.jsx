import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import Typography from "@material-ui/core/Typography";
import Paper from "@material-ui/core/Paper";

const useStyles = makeStyles(theme => ({
  container: {
    display: "block",
    position: "absolute",
    left: theme.spacing(3),
    bottom: theme.spacing(3),
    padding: theme.spacing(1)
  }
}));

const RoomCode = ({ room_id }) => {
  const classes = useStyles();

  return (
    <Paper className={classes.container} variant="outlined">
      <Typography variant="subtitle2" color="textSecondary">
        Join Code
      </Typography>

      <Typography variant="h4">{room_id}</Typography>
    </Paper>
  );
};

export default RoomCode;

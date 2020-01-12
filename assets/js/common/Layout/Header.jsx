import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import AppBar from "@material-ui/core/AppBar";
import Toolbar from "@material-ui/core/Toolbar";
import Typography from "@material-ui/core/Typography";

const useStyles = makeStyles(theme => ({
  root: {
    alignItems: "center"
  }
}));

const Header = () => {
  const classes = useStyles();

  return (
    <AppBar position="fixed" color="primary" className={classes.root}>
      <Toolbar>
        <Typography variant="h6">Trivial Trivia</Typography>
      </Toolbar>
    </AppBar>
  );
};

export default Header;

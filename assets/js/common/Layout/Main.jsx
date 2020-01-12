import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import Grid from "@material-ui/core/Grid";

const useStyles = makeStyles(theme => ({
  root: {
    marginTop: theme.spacing(8),
    paddingTop: theme.spacing(4)
  }
}));

const Main = ({ children }) => {
  const classes = useStyles();

  return (
    <Grid
      container
      direction="row"
      justify="center"
      alignItems="flex-start"
      className={classes.root}
    >
      <Grid item xs={10} sm={6}>
        {children}
      </Grid>
    </Grid>
  );
};

export default Main;

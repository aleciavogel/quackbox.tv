import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import { connect } from "react-redux";
import Typography from "@material-ui/core/Typography";
import Paper from "@material-ui/core/Paper";

const useStyles = makeStyles(theme => ({
  container: {
    display: "block",
    position: "absolute",
    right: theme.spacing(3),
    bottom: theme.spacing(3),
    padding: theme.spacing(1)
  },
  number: {
    textAlign: "center"
  }
}));

const AudienceCounter = ({ audience_members }) => {
  const classes = useStyles();

  return (
    <Paper className={classes.container} variant="outlined">
      <Typography variant="subtitle2" color="textSecondary">
        Audience
      </Typography>

      <Typography variant="h4" className={classes.number}>
        {audience_members.length}
      </Typography>
    </Paper>
  );
};

function mapStateToProps(state) {
  const { audience_members } = state;
  return {
    audience_members
  };
}

export default connect(mapStateToProps)(AudienceCounter);

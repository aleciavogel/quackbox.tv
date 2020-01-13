import React from "react";
import { connect } from "react-redux";
import { makeStyles } from "@material-ui/core/styles";

import Grid from "@material-ui/core/Grid";
import Typography from "@material-ui/core/Typography";

import Category from "../components/SelectCategory/Category";

const useStyles = makeStyles(theme => ({
  centerText: {
    textAlign: "center",
    paddingTop: theme.spacing(6)
  },
  categoryList: {
    marginTop: theme.spacing(4)
  }
}));

const SelectCategory = ({ chooser, categories }) => {
  const classes = useStyles();
  const category_list = categories.map(category => (
    <Category category={category} key={category} />
  ));

  return (
    <Grid item className={classes.centerText} xs={12}>
      <Typography variant="h3" gutterBottom>
        {chooser.name} is selecting a category...
      </Typography>

      <Grid
        container
        justify="center"
        alignItems="flex-start"
        className={classes.categoryList}
      >
        <Grid item xs={8} sm={6} md={5} lg={4}>
          {category_list}
        </Grid>
      </Grid>
    </Grid>
  );
};

const mapStateToProps = state => {
  const { chooser, categories } = state;

  return {
    chooser,
    categories
  };
};

export default connect(mapStateToProps)(SelectCategory);

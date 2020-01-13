import React from 'react'
import { connect } from 'react-redux'
import { makeStyles } from '@material-ui/core/styles'
import Box from '@material-ui/core/Box'
import Typography from '@material-ui/core/Typography'
import Button from '@material-ui/core/Button'
import Grid from '@material-ui/core/Grid'

import { selectCategory } from '../actions'

const useStyles = makeStyles(theme => ({
  title: {
    marginBottom: theme.spacing(3)
  },
  centeredText: {
    textAlign: 'center'
  },
  button: {
    width: '100%',
    marginBottom: theme.spacing(2)
  }
}))

const SelectCategory = ({ is_choosing, dispatch, channel, categories }) => {
  const classes = useStyles()

  if (is_choosing) {
    const category_list = categories.map(category => (
      <Button 
        key={category}
        variant="contained"
        size="large"
        className={classes.button}
        onClick={() => dispatch(selectCategory(channel, category))}
      >
        {category}
      </Button>
    )) 
    return (
      <Box className={classes.centeredText}>
        <Typography variant="h5" gutterBottom className={classes.title}> 
          Select a category
        </Typography>
        <Grid container justify="center" alignItems="flex-start">
          <Grid item xs={7} className={classes.item}>
            {category_list}
          </Grid>
        </Grid>
      </Box>
    )
  } else {
    return (
      <Box className={classes.centeredText}>
        <Typography variant="body1">
          Waiting on category selection...
        </Typography>
      </Box>
    )
  }
}

function mapStateToProps(state) {
  const { is_choosing, channel, categories } = state

  return {
    is_choosing,
    channel,
    categories
  }
}

export default connect(mapStateToProps)(SelectCategory) 

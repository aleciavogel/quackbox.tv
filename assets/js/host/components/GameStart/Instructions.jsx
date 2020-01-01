import React from 'react'
import { makeStyles } from '@material-ui/core/styles'
import Typography from '@material-ui/core/Typography'
import Box from '@material-ui/core/Box'
import Button from '@material-ui/core/Button'

const useStyles = makeStyles(theme => ({
  button: {
    marginLeft: theme.spacing(1),
    marginRight: theme.spacing(1),
  }
}))

const Instructions = () => {
  const classes = useStyles()

  return (
    <Box className={classes.root}>
      <Typography variant="h5">
        Press
        <Button variant="contained" className={classes.button}>
          Everybody's In
        </Button>
        to start the game
      </Typography>
    </Box>
  )
}

export default Instructions
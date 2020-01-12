import React from 'react'
import { makeStyles } from '@material-ui/core/styles'
import Box from '@material-ui/core/Box'
import Typography from '@material-ui/core/Typography'
import CircularProgress from '@material-ui/core/CircularProgress'

const useStyles = makeStyles(theme => ({
  root: {
    display: 'block',
    position: 'absolute',
    top: '50%',
    left: '50%',
    transform: 'translate(-50%, -50%)',
    textAlign: 'center',
  },
  spinner: {
    marginBottom: theme.spacing(1)
  }
}))

const Loading = () => {
  const classes = useStyles()

  return (
    <Box className={classes.root}>
      <CircularProgress 
        className={classes.spinner}
        color="primary"
      />

      <Typography variant="h4">
        Loading...
      </Typography>
    </Box>
  )
}

export default Loading
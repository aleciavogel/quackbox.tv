import React from 'react'
import { makeStyles } from '@material-ui/core/styles'
import Typography from '@material-ui/core/Typography'

const useStyles = makeStyles(theme => ({
  title: {
    // fontWeight: 700
  }
}))

const Title = (props) => {
  const classes = useStyles()

  return (
    <Typography variant="h1" className={classes.title}>
      trivial trivia
    </Typography>
  )
}

export default Title
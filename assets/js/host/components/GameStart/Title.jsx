import React from 'react'
import { makeStyles } from '@material-ui/core/styles'
import Typography from '@material-ui/core/Typography'

const useStyles = makeStyles((theme) => ({
  title: {
    textTransform: 'lowercase'
  }
}))

const Title = () => {
  const classes = useStyles()

  return (
    <Typography variant="h1" className={classes.title}>
      Trivial Trivia
    </Typography>
  )
}

export default Title
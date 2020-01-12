import React from 'react'
import { makeStyles } from '@material-ui/core/styles'
import Grid from '@material-ui/core/Grid'

import {
  PlayerList,
  Instructions,
  Title
} from '../components/GameStart'

const useStyles = makeStyles(theme => ({
  leftSide: {
    paddingLeft: theme.spacing(3)
  }
}))

const GameStart = () => {
  const classes = useStyles()

  return (
    <>
      <Grid item xs={8} className={classes.leftSide}>
        <Title />
        <Instructions />
      </Grid>
      <Grid item xs={4}>
        <PlayerList />
      </Grid>
    </>
  )
}

export default GameStart

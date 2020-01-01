import React from 'react'
import { makeStyles } from '@material-ui/core/styles'
import Grid from '@material-ui/core/Grid'

import {
  PlayerList,
  AudienceCounter,
  RoomCode,
  Instructions,
  Title
} from '../components/GameStart'

const useStyles = makeStyles(theme => ({
  root: {
    height: '100vh'
  },
  leftSide: {
    paddingLeft: theme.spacing(3)
  }
}))

const GameStart = ({ room_id }) => {
  const classes = useStyles()

  return (
    <Grid container className={classes.root}>
      <Grid item xs={8} className={classes.leftSide}>
        <Title />
        <Instructions />
        <AudienceCounter />
        <RoomCode room_id={room_id} />
      </Grid>
      <Grid item xs={4}>
        <PlayerList />
      </Grid>
    </Grid>
  )
}

export default GameStart
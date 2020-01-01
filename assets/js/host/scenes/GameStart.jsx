import React from 'react'
import Grid from '@material-ui/core/Grid'

import {
  PlayerList,
  AudienceCounter,
  RoomCode,
  Title
} from '../components/GameStart'

const GameStart = ({ room_id }) => {
  return (
    <Grid container>
      <Grid item xs={8}>
        <Title />
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
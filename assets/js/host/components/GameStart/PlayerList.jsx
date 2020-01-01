import React from 'React'
import { connect } from 'react-redux'

import PlayerListItem from './PlayerListItem'

const PlayerList = ({ players }) => {
  const player_items = players.map(player => (
    <PlayerListItem name={player.name} key={player.id} />
  ))

  return (
    <ul>
      {player_items}
    </ul>
  )
}

function mapStateToProps(state) {
  const { players } = state
  return {
    players
  }
}

export default connect(mapStateToProps)(PlayerList)
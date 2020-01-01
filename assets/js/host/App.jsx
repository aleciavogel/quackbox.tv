import React, { Component } from 'react'
import { connect } from 'react-redux'

import { joinRoom } from './actions'

class App extends Component {
  componentDidMount() {
    const { dispatch, socket, room_id } = this.props
    socket.connect()
    dispatch(joinRoom(socket, room_id))
  }

  render() {
    const { players, audience_members } = this.props

    return (
      <>
        <h1>Welcome to the host component</h1>

        Players:
        <ul>
          {players.map(player => (
            <li key={player.id}>{player.name}</li>
          ))}
        </ul>

        Audience Members:
        <ul>
          {audience_members.map(audience => (
            <li key={audience.id}>{audience.name}</li>
          ))}
        </ul>
      </>
    )
  }
}

function mapStateToProps(state) {
  const { players, audience_members } = state

  return {
    players,
    audience_members
  }
}

export default connect(mapStateToProps)(App)
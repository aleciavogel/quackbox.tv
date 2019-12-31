import React, { Component } from 'react'
import { Socket, Presence } from 'phoenix'

export default class App extends Component {
  constructor(props) {
    super(props)

    this.state = {
      presences: {},
      players: [],
      audience_members: []
    }
  }

  setupChannelMessageHandlers(channel) {
    const self = this

    channel.on('presence_state', response => {
      self.syncPresentUsers(response)
    })

    channel.on('presence_diff', response => {
      self.syncPresentUsers(response)
    })
  }

  syncPresentUsers(response) {
    const players = []
    const audience_members = []
    const { presences: old_presences } = this.state
    const new_presences = Presence.syncDiff(old_presences, response)

    Presence.list(new_presences).map(p => {
      const participant = p.metas[0]

      if (participant.type == 'player') {
        players.push(participant)
      } else {
        audience_members.push(participant)
      }
    })

    this.setState({
      presences: new_presences,
      players,
      audience_members
    })
  }

  componentDidMount() {
    let socket = new Socket(
      "/socket", 
      {
        params: {
          host_token: window.hostToken,
          access_code: window.roomID
        }
      }
    )

    socket.connect()

    let room_id = window.roomID
    let channel = socket.channel(`room:${room_id}`, {})
    const self = this

    channel.join()
      .receive('ok', response => {
        console.log("Joined successfully", response)
        self.setupChannelMessageHandlers(channel)
      })
      .receive('error', response => {
        console.log("Unable to join.", response)
      })
  }

  render() {
    const { players, audience_members } = this.state

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
import React, { Component } from 'react'
import { Socket } from 'phoenix'

export default class App extends Component {
  constructor(props) {
    super(props)

    this.state = {
      players: []
    }
  }

  setupChannelMessageHandlers(channel) {
    channel.on("player:joined", ({name}) => {
      console.log(`${name} has joined the game`)
    })
    channel.on("audience:joined", ({name}) => {
      console.log(`${name} has joined the game as an audience member`)
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
    const self = this;

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
    return (
      <h1>Welcome to the host component</h1>
    )
  }
}
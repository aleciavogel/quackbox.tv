import React, { Component } from 'react'
import { Socket } from 'phoenix'

export default class App extends Component {
  componentDidMount() {
    let socket = new Socket(
      "/socket", 
      {
        params: {
          audience_token: window.audienceToken,
          access_code: window.roomID
        }
      }
    )

    socket.connect()

    let room_id = window.roomID
    let channel = socket.channel(`room:${room_id}`, {})

    channel.join()
      .receive('ok', response => {
        console.log("Joined successfully", response)
      })
      .receive('error', response => {
        console.log("Unable to join.", response)
      })
  }

  render() {
    return (
      <h1>Welcome to the audience component</h1>
    )
  }
}
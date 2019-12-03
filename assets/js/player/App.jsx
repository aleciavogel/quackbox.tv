import React, { Component } from 'react'
import { Socket } from 'phoenix'

export default class App extends React.Component {
  componentDidMount() {
    let socket = new Socket(
      "/socket", 
      {
        params: {
          player_token: window.playerToken,
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
      <h1>Welcome to the player component</h1>
    )
  }
}
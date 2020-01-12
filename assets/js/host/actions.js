import { Presence } from 'phoenix'

// Connectivity-related events
export const JOIN_ROOM = 'JOIN_ROOM'
export const RECEIVE_ERROR = 'RECEIVE_ERROR'
export const UPDATE_PARTICIPANTS = 'UPDATE_PARTICIPANTS'

// Game events
export const CATEGORY_SELECT = 'CATEGORY_SELECT'

export const joinRoom = (socket, room_id) => {
  return dispatch => {
    const channel = socket.channel(`room:${room_id}`, {})
    let presences = {}

    channel.join()
      .receive('ok', response => {
        const { players, audience_members, lead_player_id } = sortPresentUsers(response.presences)

        dispatch({
          type: JOIN_ROOM,
          room: room_id,
          players,
          audience_members,
          channel,
          lead_player_id
        })

        setupPresenceEvents(channel, dispatch, presences)
        setupGameEvents(channel, dispatch)
      })
      .receive('error', ({ reason }) => {
        dispatch({
          type: RECEIVE_ERROR,
          error: reason
        })
      })
  }
}

const setupPresenceEvents = (channel, dispatch, presences) => {
  channel.on('presence_state', response => {
    presences = Presence.syncState(presences, response)
    syncPresentUsers(dispatch, presences)
  })

  channel.on('presence_diff', response => {
    presences = Presence.syncDiff(presences, response)
    syncPresentUsers(dispatch, presences)
  })
}

const setupGameEvents = (channel, dispatch) => {
  channel.on('category_select', ({ scene }) => {
    dispatch({
      type: CATEGORY_SELECT,
      scene,
    });
  });
}

const sortPresentUsers = (presences) => {
  const players = []
  const audience_members = []
  let lead_player_id = null

  Presence.list(presences).map(p => {
    const participant = p.metas[0]

    if (participant.type == 'player') {
      players.push(participant)
    } else {
      audience_members.push(participant)
    }
  })

  // Sort by the online_at timestamp
  players.sort((x, y) => (
    x.online_at - y.online_at
  ))

  if (players.length > 0) {
    lead_player_id = players[0].id
  }

  return {
    players,
    audience_members,
    lead_player_id
  }
}

const syncPresentUsers = (dispatch, presences) => {
  const { players, audience_members, lead_player_id } = sortPresentUsers(presences)

  dispatch({
    type: UPDATE_PARTICIPANTS,
    players,
    audience_members,
    lead_player_id
  })
}

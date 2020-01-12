import {
  JOIN_ROOM,
  RECEIVE_ERROR,
  UPDATE_PARTICIPANTS,
  CATEGORY_SELECT
} from './actions'

const initialState = {
  players: [],
  audience_members: [],
  room: null,
  channel: null,
  error: null,
  loading: true,
  lead_player_id: null,
  scene: "game-start"
}

const reducer = (state = initialState, action = {}) => {
  switch (action.type) {
    case JOIN_ROOM:
      return {
        ...state,
        room: action.room,
        channel: action.channel,
        players: action.players,
        audience_members: action.audience_members,
        error: null,
        loading: false,
        lead_player_id: action.lead_player_id
      }
    case UPDATE_PARTICIPANTS:
      return {
        ...state,
        players: action.players,
        audience_members: action.audience_members,
        lead_player_id: action.lead_player_id,
        error: null
      }
    case RECEIVE_ERROR:
      return {
        ...state,
        error: action.error,
        loading: false
      }
    case CATEGORY_SELECT:
      return {
        ...state,
        scene: action.scene
      }
    default:
      return state
  }
}

export default reducer

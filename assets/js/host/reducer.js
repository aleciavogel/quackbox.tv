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
  scene: "game-start",
  chooser: {
    name: null,
    id: null
  },
  categories: []
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
        scene: action.scene,
        chooser: action.chooser,
        categories: action.categories,
        error: null,
        loading: false
      }
    case UPDATE_PARTICIPANTS:
      return {
        ...state,
        players: action.players,
        audience_members: action.audience_members,
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
        scene: action.scene,
        chooser: action.chooser,
        categories: action.categories
      }
    default:
      return state
  }
}

export default reducer

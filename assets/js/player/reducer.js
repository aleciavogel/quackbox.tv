import { JOIN_ROOM, RECEIVE_ERROR, CATEGORY_SELECT } from "./actions";

const initialState = {
  room: null,
  channel: null,
  player: {
    name: null,
    is_lead: null
  },
  error: null,
  loading: true,
  scene: "game-start",
  categories: [],
  is_choosing: false
};

const reducer = (state = initialState, action = {}) => {
  switch (action.type) {
    case JOIN_ROOM:
      return {
        ...state,
        room: action.room,
        channel: action.channel,
        player: action.player,
        scene: action.scene,
        is_choosing: action.is_choosing,
        categories: action.categories,
        error: null,
        loading: false
      };
    case RECEIVE_ERROR:
      return {
        ...state,
        error: action.error,
        loading: false
      };
    case CATEGORY_SELECT:
      return {
        ...state,
        scene: action.scene,
        is_choosing: action.is_choosing,
        categories: action.categories
      };
    default:
      return state;
  }
};

export default reducer;

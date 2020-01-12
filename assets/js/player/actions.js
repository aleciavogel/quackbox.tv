// Connectivity-related events
export const JOIN_ROOM = "JOIN_ROOM";
export const RECEIVE_ERROR = "RECEIVE_ERROR";

// Game events
export const CATEGORY_SELECT = "CATEGORY_SELECT";

// Player events
export const START_GAME = "START_GAME";
export const SELECT_CATEGORY = "SELECT_CATEGORY";

// Initialize event listeners
export const joinRoom = (socket, room_id) => {
  return dispatch => {
    const channel = socket.channel(`room:${room_id}`, {});

    channel
      .join()
      .receive("ok", ({ player, scene, is_choosing, categories }) => {
        dispatch({
          type: JOIN_ROOM,
          room: room_id,
          channel,
          player,
          scene,
          is_choosing,
          categories
        });
        setupGameEvents(channel, dispatch, player.id);
      })
      .receive("error", ({ reason }) => {
        dispatch({
          type: RECEIVE_ERROR,
          error: reason
        });
      });
  };
};

export const selectCategory = (channel, category) => {
  channel.push('select_category', {category})

  return {
    type: SELECT_CATEGORY
  }
}

export const startGame = channel => {
  channel.push("start_game", {});

  return {
    type: START_GAME
  };
};

const setupGameEvents = (channel, dispatch, player_id) => {
  channel.on("category_select", ({ scene, chooser, categories }) => {
    const is_choosing = player_id == chooser.id

    dispatch({
      type: CATEGORY_SELECT,
      scene,
      is_choosing,
      categories
    });
  });
};

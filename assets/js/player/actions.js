// Connectivity-related events
export const JOIN_ROOM = "JOIN_ROOM";
export const RECEIVE_ERROR = "RECEIVE_ERROR";

// Game events
export const CATEGORY_SELECT = "CATEGORY_SELECT";

// Player events
export const START_GAME = "START_GAME";

// Initialize event listeners
export const joinRoom = (socket, room_id) => {
  return dispatch => {
    const channel = socket.channel(`room:${room_id}`, {});

    channel
      .join()
      .receive("ok", ({ player }) => {
        dispatch({
          type: JOIN_ROOM,
          room: room_id,
          channel,
          player
        });
        setupGameEvents(channel, dispatch);
      })
      .receive("error", ({ reason }) => {
        dispatch({
          type: RECEIVE_ERROR,
          error: reason
        });
      });
  };
};

export const startGame = channel => {
  channel.push("start_game", {});

  return {
    type: START_GAME
  };
};

const setupGameEvents = (channel, dispatch) => {
  channel.on("category_select", ({ scene }) => {
    dispatch({
      type: CATEGORY_SELECT,
      scene
    });
  });
};

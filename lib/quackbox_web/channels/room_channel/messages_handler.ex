defmodule QuackboxWeb.RoomChannel.MessagesHandler do
  defmacro handle_incoming(messages, with_module: module) do
    quote bind_quoted: [messages: messages, module: module] do
      Enum.each(messages, fn message ->
        def handle_in(unquote(Atom.to_string(message)), data, socket) do
          apply(unquote(module), unquote(message), [data, socket])
        end
      end)
    end
  end

  defmacro handle_outgoing(messages, with_module: module) do
    quote bind_quoted: [messages: messages, module: module] do
      Enum.each(messages, fn message ->
        def handle_out(unquote(Atom.to_string(message)), data, socket) do
          apply(unquote(module), unquote(message), [data, socket])
        end
      end)
    end
  end

  defmacro handle_broadcasts(messages, with_module: module) do
    quote bind_quoted: [messages: messages, module: module] do
      Enum.each(messages, fn message ->
        def handle_info({unquote(message), data}, socket) do
          apply(unquote(module), unquote(message), [data, socket])
        end
      end)
    end
  end
end

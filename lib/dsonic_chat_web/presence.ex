defmodule DsonicChatWeb.Presence do
  use Phoenix.Presence,
    otp_app: :dsonic_chat,
    pubsub_server: DsonicChat.PubSub
end

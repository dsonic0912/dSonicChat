defmodule DsonicChatWeb.ChatLive do
  use DsonicChatWeb, :live_view

  @impl true
  def mount(params, _session, socket) do
    username = Map.get(params, "username")

    if username do
      # If user is logged in, join the chat
      if connected?(socket) do
        # Broadcast user presence when connected
        DsonicChatWeb.Presence.track(
          self(),
          "users",
          username,
          %{
            online_at: DateTime.utc_now(),
            status: "active"
          }
        )

        # Subscribe to presence updates
        Phoenix.PubSub.subscribe(DsonicChat.PubSub, "users")
        # Subscribe to chat messages
        Phoenix.PubSub.subscribe(DsonicChat.PubSub, "chat")
      end

      # Get current online users
      users =
        DsonicChatWeb.Presence.list("users")
        |> Enum.map(fn {username, %{metas: [meta | _]}} ->
          {username, meta}
        end)
        |> Enum.into(%{})

      {:ok,
       assign(socket,
         username: username,
         users: users,
         message: "",
         messages: [],
         active_conversation: nil
       )}
    else
      # Redirect to login if no username
      {:ok, push_redirect(socket, to: ~p"/login")}
    end
  end

  @impl true
  def handle_event("send_message", %{"message" => message}, socket) when message != "" do
    # Broadcast the message to all users
    message_data = %{
      id: System.unique_integer([:positive]),
      content: message,
      sender: socket.assigns.username,
      timestamp: DateTime.utc_now()
    }

    Phoenix.PubSub.broadcast(DsonicChat.PubSub, "chat", {:new_message, message_data})

    {:noreply, assign(socket, message: "")}
  end

  @impl true
  def handle_event("send_message", _, socket) do
    # Don't send empty messages
    {:noreply, socket}
  end

  @impl true
  def handle_event("select_conversation", %{"username" => username}, socket) do
    # Set the active conversation
    {:noreply, assign(socket, active_conversation: username)}
  end

  @impl true
  def handle_event("update_message", %{"message" => message}, socket) do
    # Update the message input field
    {:noreply, assign(socket, message: message)}
  end

  @impl true
  def handle_info({:new_message, message}, socket) do
    # Add the new message to the list
    messages = [message | socket.assigns.messages]
    {:noreply, assign(socket, messages: messages)}
  end

  @impl true
  def handle_info(%Phoenix.Socket.Broadcast{event: "presence_diff"}, socket) do
    # Update the users list based on presence changes
    users =
      DsonicChatWeb.Presence.list("users")
      |> Enum.map(fn {username, %{metas: [meta | _]}} ->
        {username, meta}
      end)
      |> Enum.into(%{})

    {:noreply, assign(socket, users: users)}
  end
end

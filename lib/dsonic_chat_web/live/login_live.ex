defmodule DsonicChatWeb.LoginLive do
  use DsonicChatWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, username: "", error: nil)}
  end

  @impl true
  def handle_event("login", %{"username" => username}, socket) when username != "" do
    # Store username in session and redirect to chat
    {:noreply,
     socket
     |> push_navigate(to: ~p"/chat?username=#{username}")}
  end

  @impl true
  def handle_event("login", %{"username" => ""}, socket) do
    # Show error for empty username
    {:noreply, assign(socket, error: "Username cannot be empty")}
  end

  @impl true
  def handle_event("update_username", %{"username" => username}, socket) do
    # Update the username input field
    {:noreply, assign(socket, username: username, error: nil)}
  end
end

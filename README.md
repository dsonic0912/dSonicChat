# dSonicChat

A lightweight, real-time chat application built with Phoenix LiveView and Elixir.

## Features

- **Simple Username Login**: No registration or authentication required - just enter a username to start chatting
- **Real-time Messaging**: Instant message delivery using Phoenix PubSub and LiveView
- **Online Status Tracking**: See who's currently online with Phoenix Presence
- **Modern UI**: Clean, responsive interface built with TailwindCSS

## Getting Started

### Prerequisites

- Elixir 1.14 or later
- Node.js (for asset compilation)

### Installation

1. Clone the repository

   ```bash
   git clone https://github.com/dsonic0912/dSonicChat
   cd dsonic_chat
   ```

2. Install dependencies

   ```bash
   mix setup
   ```

3. Start the Phoenix server

   ```bash
   mix phx.server
   ```

4. Visit [`localhost:4000`](http://localhost:4000) in your browser

## How It Works

- **Username-only Login**: Users enter a username on the login page to join the chat
- **Presence Tracking**: The app tracks online users in real-time using Phoenix Presence
- **Message Broadcasting**: Messages are broadcast to all connected users via Phoenix PubSub

## Development

### Key Components

- **ChatLive**: Main LiveView module handling chat functionality
- **LoginLive**: LiveView module for the login page
- **Presence**: Tracks online users and their status

### Project Structure

- `lib/dsonic_chat_web/live/` - LiveView modules
- `lib/dsonic_chat_web/components/` - UI components and layouts
- `lib/dsonic_chat_web/presence.ex` - User presence tracking

## Deployment

For production deployment, see the [Phoenix deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Built with [Phoenix Framework](https://www.phoenixframework.org/)
- UI styled with [TailwindCSS](https://tailwindcss.com/)

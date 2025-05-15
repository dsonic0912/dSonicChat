defmodule DsonicChat.Repo do
  use Ecto.Repo,
    otp_app: :dsonic_chat,
    adapter: Ecto.Adapters.Postgres
end

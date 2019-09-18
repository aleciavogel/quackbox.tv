defmodule Quackbox.Repo do
  use Ecto.Repo,
    otp_app: :quackbox,
    adapter: Ecto.Adapters.Postgres
end

# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :quackbox,
  ecto_repos: [Quackbox.Repo]

# Configures the endpoint
config :quackbox, QuackboxWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "C/DM4b3w+mh4qgXHzMgoDCc3mkbgtYEH806fLapRrYdekwc0/Mpwh1zd4GaaTmoI",
  render_errors: [view: QuackboxWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Quackbox.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Pow Configuration
config :quackbox, :pow,
  user: Quackbox.Users.User,
  repo: Quackbox.Repo,
  web_module: QuackboxWeb

# Configure NanoID
config :nanoid,
  size: 4,
  alphabet: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

# PaperTrail configuration
config :paper_trail, 
  repo: Quackbox.Repo, 
  originator: [name: :user, model: Quackbox.Users.User]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :grouptracks,
  ecto_repos: [Grouptracks.Repo]

config :grouptracks, current_env: Mix.env

# Configures the endpoint
config :grouptracks, GrouptracksWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eNH4HEwFnOXSzvWIsq2P7IqIYEDACFCWqNr9zpjE3eLmXVJ6nHaHQU0I3GtQbgxj",
  render_errors: [view: GrouptracksWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Grouptracks.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
import_config "prod.secret.exs"
import_config "dev.secret.exs"

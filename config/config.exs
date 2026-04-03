import Config

#### General configuration, everything else should be in `jacobin.exs` or `Jacobin.RuntimeConfig`

config :bonfire, :repo_module, Bonfire.Common.Repo

config :phoenix, :json_library, Jason

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :mime, :types, %{
  "application/activity+json" => ["activity+json"]
}

config :jacobin, :otp_app, :jacobin
config :bonfire_common, :otp_app, :jacobin
config :jacobin, :repo_module, Bonfire.Common.Repo
config :jacobin, ecto_repos: [Bonfire.Common.Repo]
config :bonfire_common, :localisation_path, "priv/localisation"

config :bonfire_data_identity, Bonfire.Data.Identity.Credential, hasher_module: Argon2

import_config "../../ember/config/bonfire_data.exs"

import_config "jacobin.exs"

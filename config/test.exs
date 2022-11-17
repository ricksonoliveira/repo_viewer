import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :repo_viewer, RepoViewerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "c6zg6yeNTIoGIaZsOYjGuDS2bVh8vxYdfCcS7pgpKuhltP4w/+ZrWdQteQxORuAL",
  server: false

# In test we don't send emails.
config :repo_viewer, RepoViewer.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :tesla, adapter: Tesla.Mock

import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :pbkdf2_elixir, :rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :reading_list_ex, ReadingListEx.Repo,
  username: "postgres",
  password: "postgres",
  database: "reading_list_ex_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :reading_list_ex, ReadingListExWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "W1jwnRLaN9pzD8BpJuDoJWF5LdZXnKNh8bFNe+gMtcbGKS5f4FOQ32tKPSl0a5Y9",
  server: false

# In test we don't send emails.
config :reading_list_ex, ReadingListEx.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

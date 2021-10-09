defmodule ReadingListEx.Repo do
  use Ecto.Repo,
    otp_app: :reading_list_ex,
    adapter: Ecto.Adapters.Postgres
end

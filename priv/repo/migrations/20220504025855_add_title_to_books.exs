defmodule ReadingListEx.Repo.Migrations.AddTitleToBooks do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :title, :string
      add :subtitle, :string
      add :google_api_id, :string
    end
  end
end

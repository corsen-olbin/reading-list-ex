defmodule ReadingListEx.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :first_name, :string
      add :last_name, :string
      add :username, :string
      add :favorite_genre, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:profiles, [:username])
    create index(:profiles, [:user_id])
  end
end

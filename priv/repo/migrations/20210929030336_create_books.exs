defmodule ReadingListEx.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :isbn_13, :string
      add :profile_id, references(:profiles, on_delete: :nothing)

      timestamps()
    end

    create index(:books, [:profile_id])
  end
end

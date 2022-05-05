defmodule ReadingListEx.Repo.Migrations.CreateProfileBooks do
  use Ecto.Migration

  def change do
    alter table(:books) do
      remove :profile_id
    end

    create table(:profile_books) do
      add :profile_id, references(:profiles, on_delete: :nothing), null: false
      add :book_id, references(:books, on_delete: :nothing), null: false
      add :rating, :integer

      timestamps()
    end

    create index(:profile_books, [:profile_id])
    create index(:profile_books, [:book_id])
  end
end

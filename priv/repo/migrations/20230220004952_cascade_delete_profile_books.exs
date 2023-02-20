defmodule ReadingListEx.Repo.Migrations.CascadeDeleteProfileBooks do
  use Ecto.Migration

  def change do
    drop constraint(:profile_books, :profile_books_profile_id_fkey)

    alter table("profile_books") do
      modify :profile_id, references(:profiles, on_delete: :delete_all), null: false
    end
  end
end

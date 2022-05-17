defmodule ReadingListEx.Repo.Migrations.AddUniqueProfileBooksIndex do
  use Ecto.Migration

  def change do

    create unique_index(:profile_books, [:profile_id, :book_id], name: :unique_profile_book)

  end
end

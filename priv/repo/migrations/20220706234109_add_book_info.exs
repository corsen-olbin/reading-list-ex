defmodule ReadingListEx.Repo.Migrations.AddBookInfo do
  use Ecto.Migration

  def change do
    alter table("books") do
      add :image_url, :text
      add :authors, :text
    end
  end
end

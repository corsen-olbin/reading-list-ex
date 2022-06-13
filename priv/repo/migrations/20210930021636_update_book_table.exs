defmodule ReadingListEx.Repo.Migrations.UpdateBookTable do
  use Ecto.Migration

  def change do
    alter table(:books) do
      modify :isbn_13, :string, null: false
      modify :profile_id, :bigint, null: false
    end
  end
end

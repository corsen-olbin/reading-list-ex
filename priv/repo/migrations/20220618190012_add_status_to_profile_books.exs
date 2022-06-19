defmodule ReadingListEx.Repo.Migrations.AddStatusToProfileBooks do
  use Ecto.Migration

  def change do
    alter table(:profile_books) do
      add :status, :integer
    end
  end
end

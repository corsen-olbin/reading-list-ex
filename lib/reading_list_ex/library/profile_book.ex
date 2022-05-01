defmodule ReadingListEx.Library.ProfileBook do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profile_books" do

    belongs_to :profile, ReadingListEx.Library.Profile
    belongs_to :book, ReadingListEx.Library.Book

    timestamps()
  end
end

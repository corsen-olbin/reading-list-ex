defmodule ReadingListEx.Library.ProfileBook do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profile_books" do
    field :status, Ecto.Enum, values: [reading: 0, backlog: 1, read: 2, dnf: 3]

    belongs_to :profile, ReadingListEx.Library.Profile
    belongs_to :book, ReadingListEx.Library.Book

    timestamps()
  end

  def changeset(profile_book, attrs) do
    profile_book
    |> cast(attrs, [:status])
    |> unique_constraint(:unique_profile_book, name: :unique_profile_book)
  end
end

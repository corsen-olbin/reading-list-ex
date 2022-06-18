defmodule ReadingListEx.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :isbn_13, :string
    field :title, :string
    field :subtitle, :string
    field :google_api_id, :string

    has_many :profile_book, ReadingListEx.Library.ProfileBook

    has_many :profile,
      through: [:profile_book, :profile]

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:isbn_13, :title, :subtitle, :google_api_id])
    |> validate_required([:isbn_13, :title, :google_api_id])
  end
end

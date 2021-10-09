defmodule ReadingListEx.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :isbn_13, :string

    belongs_to :profile, ReadingListEx.Library.Profile

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> IO.inspect
    |> cast(attrs, [:isbn_13, :profile_id])
    |> validate_required([:isbn_13, :profile_id])
  end
end

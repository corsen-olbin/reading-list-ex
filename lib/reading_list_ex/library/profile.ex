defmodule ReadingListEx.Library.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profiles" do
    field :favorite_genre, :string
    field :first_name, :string
    field :last_name, :string
    field :username, :string
    field :user_id, :id

    has_many :book, ReadingListEx.Library.Book

    timestamps()
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:first_name, :last_name, :username, :favorite_genre])
    |> validate_required([:first_name, :last_name, :username, :favorite_genre])
    |> unique_constraint(:username)
  end
end

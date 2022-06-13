defmodule ReadingListEx.Library.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "profiles" do
    field :favorite_genre, :string
    field :first_name, :string
    field :last_name, :string
    field :username, :string

    belongs_to :user, ReadingListEx.Accounts.User

    has_many :profile_book, ReadingListEx.Library.ProfileBook

    has_many :book,
      through: [:profile_book, :book]

    timestamps()
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:first_name, :last_name, :username, :favorite_genre])
    |> validate_required([:first_name, :last_name, :username])
    |> validate_length(:username, min: 4, max: 30)
    |> unique_constraint(:username)
  end
end

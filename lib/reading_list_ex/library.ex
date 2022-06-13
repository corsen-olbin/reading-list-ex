defmodule ReadingListEx.Library do
  @moduledoc """
  The Library context.
  """

  import Ecto.Query, warn: false
  alias ReadingListEx.Repo

  alias ReadingListEx.Library.Profile

  @doc """
  Returns the list of profiles.
  
  ## Examples
  
      iex> list_profiles()
      [%Profile{}, ...]
  
  """
  def list_profiles do
    Repo.all(Profile)
  end

  @doc """
  Gets a single profile.
  
  Raises `Ecto.NoResultsError` if the Profile does not exist.
  
  ## Examples
  
      iex> get_profile!(123)
      %Profile{}
  
      iex> get_profile!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_profile!(id), do: Repo.get!(Profile, id)

  def get_profile_by_user(user) do
    query =
      from profile in ReadingListEx.Library.Profile,
        where: [user_id: ^user.id],
        select: profile

    Repo.one(query)
  end

  @doc """
  Creates a profile.
  
  ## Examples
  
      iex> create_profile(%{field: value})
      {:ok, %Profile{}}
  
      iex> create_profile(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_profile(attrs \\ %{}) do
    %Profile{}
    |> Profile.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a profile.
  
  ## Examples
  
      iex> update_profile(profile, %{field: new_value})
      {:ok, %Profile{}}
  
      iex> update_profile(profile, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_profile(%Profile{} = profile, attrs) do
    profile
    |> Profile.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a profile.
  
  ## Examples
  
      iex> delete_profile(profile)
      {:ok, %Profile{}}
  
      iex> delete_profile(profile)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_profile(%Profile{} = profile) do
    Repo.delete(profile)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking profile changes.
  
  ## Examples
  
      iex> change_profile(profile)
      %Ecto.Changeset{data: %Profile{}}
  
  """
  def change_profile(%Profile{} = profile, attrs \\ %{}) do
    Profile.changeset(profile, attrs)
  end

  alias ReadingListEx.Library.Book

  @doc """
  Returns the list of books.
  
  ## Examples
  
      iex> list_books()
      [%Book{}, ...]
  
  """
  def list_books do
    Repo.all(Book)
  end

  @doc """
  Gets a single book.
  
  Raises `Ecto.NoResultsError` if the Book does not exist.
  
  ## Examples
  
      iex> get_book!(123)
      %Book{}
  
      iex> get_book!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_book!(id), do: Repo.get!(Book, id)

  @doc """
  Gets a single book by google_api_id
  
  Returns nil if the Book does not exist.
  
  ## Examples
  
      iex> get_book_by_isbn13(123)
      %Book{}
  
      iex> get_book_by_isbn13(456)
      nil
  
  """
  def get_book_by_google_api_id(google_id), do: Repo.get_by(Book, google_api_id: google_id)

  @doc """
  Creates a book.
  
  ## Examples
  
      iex> create_book(%{field: value})
      {:ok, %Book{}}
  
      iex> create_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book.
  
  ## Examples
  
      iex> update_book(book, %{field: new_value})
      {:ok, %Book{}}
  
      iex> update_book(book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a book.
  
  ## Examples
  
      iex> delete_book(book)
      {:ok, %Book{}}
  
      iex> delete_book(book)
      {:error, %Ecto.Changeset{}}
  
  """
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book changes.
  
  ## Examples
  
      iex> change_book(book)
      %Ecto.Changeset{data: %Book{}}
  
  """
  def change_book(%Book{} = book, attrs \\ %{}) do
    Book.changeset(book, attrs)
  end

  alias ReadingListEx.Library.ProfileBook

  @doc """
  Gets a single book.
  
  Raises `Ecto.NoResultsError` if the Book does not exist.
  
  ## Examples
  
      iex> get_book!(123)
      %Book{}
  
      iex> get_book!(456)
      ** (Ecto.NoResultsError)
  
  """
  def get_profile_book(id), do: Repo.get(ProfileBook, id)

  def get_profile_books_by_profile(profile) do
    query =
      from profile_book in ReadingListEx.Library.ProfileBook,
        where: [profile_id: ^profile.id],
        preload: [:book],
        select: profile_book

    Repo.all(query)
  end

  @doc """
  Creates a profile.
  
  ## Examples
  
      iex> create_profile_book(%{field: value})
      {:ok, %ProfileBook{}}
  
      iex> create_profile(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  
  """
  def create_profile_book(%Profile{} = profile, %Book{} = book) do
    %ProfileBook{}
    |> ProfileBook.changeset()
    |> Ecto.Changeset.put_assoc(:profile, profile)
    |> Ecto.Changeset.put_assoc(:book, book)
    |> Repo.insert(
      on_conflict: :nothing,
      conflict_target: [:profile_id, :book_id]
    )
  end

  def delete_profile_book(%ProfileBook{} = profile_book) do
    Repo.delete(profile_book)
  end
end

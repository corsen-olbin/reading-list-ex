defmodule ReadingListEx.LibraryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ReadingListEx.Library` context.
  """

  @doc """
  Generate a unique profile username.
  """
  def unique_profile_username, do: "some username#{System.unique_integer([:positive])}"

  @doc """
  Generate a profile.
  """
  def profile_fixture(attrs \\ %{}) do
    {:ok, profile} =
      attrs
      |> Enum.into(%{
        favorite_genre: "some favorite_genre",
        first_name: "some first_name",
        last_name: "some last_name",
        username: unique_profile_username()
      })
      |> ReadingListEx.Library.create_profile()

    profile
  end

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        isbn_13: "some isbn_13"
      })
      |> ReadingListEx.Library.create_book()

    book
  end
end

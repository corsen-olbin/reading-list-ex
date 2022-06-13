defmodule ReadingListEx.LibraryTest do
  use ReadingListEx.DataCase

  alias ReadingListEx.Library

  describe "profiles" do
    alias ReadingListEx.Library.Profile

    import ReadingListEx.LibraryFixtures

    @invalid_attrs %{favorite_genre: nil, first_name: nil, last_name: nil, username: nil}

    test "list_profiles/0 returns all profiles" do
      profile = profile_fixture()
      assert Library.list_profiles() == [profile]
    end

    test "get_profile!/1 returns the profile with given id" do
      profile = profile_fixture()
      assert Library.get_profile!(profile.id) == profile
    end

    test "create_profile/1 with valid data creates a profile" do
      valid_attrs = %{
        favorite_genre: "some favorite_genre",
        first_name: "some first_name",
        last_name: "some last_name",
        username: "some username"
      }

      assert {:ok, %Profile{} = profile} = Library.create_profile(valid_attrs)
      assert profile.favorite_genre == "some favorite_genre"
      assert profile.first_name == "some first_name"
      assert profile.last_name == "some last_name"
      assert profile.username == "some username"
    end

    test "create_profile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_profile(@invalid_attrs)
    end

    test "update_profile/2 with valid data updates the profile" do
      profile = profile_fixture()

      update_attrs = %{
        favorite_genre: "some updated favorite_genre",
        first_name: "some updated first_name",
        last_name: "some updated last_name",
        username: "some updated username"
      }

      assert {:ok, %Profile{} = profile} = Library.update_profile(profile, update_attrs)
      assert profile.favorite_genre == "some updated favorite_genre"
      assert profile.first_name == "some updated first_name"
      assert profile.last_name == "some updated last_name"
      assert profile.username == "some updated username"
    end

    test "update_profile/2 with invalid data returns error changeset" do
      profile = profile_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_profile(profile, @invalid_attrs)
      assert profile == Library.get_profile!(profile.id)
    end

    test "delete_profile/1 deletes the profile" do
      profile = profile_fixture()
      assert {:ok, %Profile{}} = Library.delete_profile(profile)
      assert_raise Ecto.NoResultsError, fn -> Library.get_profile!(profile.id) end
    end

    test "change_profile/1 returns a profile changeset" do
      profile = profile_fixture()
      assert %Ecto.Changeset{} = Library.change_profile(profile)
    end
  end

  describe "books" do
    alias ReadingListEx.Library.Book

    import ReadingListEx.LibraryFixtures

    @invalid_attrs %{isbn_13: nil}

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Library.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Library.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{isbn_13: "some isbn_13"}

      assert {:ok, %Book{} = book} = Library.create_book(valid_attrs)
      assert book.isbn_13 == "some isbn_13"
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Library.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      update_attrs = %{isbn_13: "some updated isbn_13"}

      assert {:ok, %Book{} = book} = Library.update_book(book, update_attrs)
      assert book.isbn_13 == "some updated isbn_13"
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Library.update_book(book, @invalid_attrs)
      assert book == Library.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Library.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Library.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Library.change_book(book)
    end
  end
end

defmodule ReadingListExWeb.ProfileBooksController do
  use ReadingListExWeb, :controller

  alias ReadingListEx.Library
  alias ReadingListEx.Library.{Book}

  def create(conn, %{"profile_book" => profile_book_params}) do
    profile = conn.assigns.current_profile

    Library.get_book_by_isbn13(profile_book_params["book"]["isbn_13"])
    |> case do
      nil ->
        Library.create_book(profile_book_params["book"])
      book ->
        {:ok, book}
    end
    |> case do
      {:ok, book = %Book{}} ->
        Library.create_profile_book(profile, book)
      error -> error
    end
    |> case do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Book added to Library successfully.")

      {:error, _} ->
        conn
        |> put_flash(:info, "Book added to Library successfully.")
    end


  end

end

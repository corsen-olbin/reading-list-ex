defmodule ReadingListExWeb.ProfileBooksController do
  use ReadingListExWeb, :controller

  alias ReadingListEx.Library
  alias ReadingListEx.Library.{Book}

  def index(conn, _params) do
    profile = conn.assigns.current_profile

    books = Library.get_profile_books_by_profile(profile)
    render(conn, "index.html", books: books)
  end

  def create(conn, %{"google_id" => google_id}) do
    profile = conn.assigns.current_profile

    {:ok, book} = ReadingListEx.GoogleAPIHelper.query_book(google_id)
    isbn_13_type = Enum.find(book["volumeInfo"]["industryIdentifiers"], fn x -> x["type"] == "ISBN_13" end)

    Library.get_book_by_google_api_id(google_id)
    |> case do
      nil ->
        Library.create_book(convert_params_to_book(book, isbn_13_type["identifier"]))
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
        |> redirect(to: Routes.search_path(conn, :index, %{"query" => "left hand of darkness"}))

      {:error, _} ->
        conn
        |> put_flash(:info, "Failed to add Book to Library.")
        |> redirect(to: Routes.search_path(conn, :index, %{"query" => "left hand of darkness"}))
    end


  end

  defp convert_params_to_book(book_params, isbn_13) do
    %{
      isbn_13: isbn_13,
      title: book_params["volumeInfo"]["title"],
      subtitle: book_params["volumeInfo"]["subtitle"],
      google_api_id: book_params["id"]
    }
  end

end

defmodule ReadingListExWeb.ProfileBooksController do
  use ReadingListExWeb, :controller

  alias ReadingListEx.Library
  alias ReadingListEx.Library.{Book}

  def index(conn, _params) do
    profile = conn.assigns.current_profile

    books = Library.get_profile_books_by_profile(profile)
    render(conn, "index.html", books: books)
  end

  def create(conn, %{"google_id" => google_id, "query" => query}) do
    profile = conn.assigns.current_profile

    {:ok, book} = ReadingListEx.GoogleAPIHelper.query_book(google_id)

    isbn_13_type =
      Enum.find(book["volumeInfo"]["industryIdentifiers"], fn x -> x["type"] == "ISBN_13" end)

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

      error ->
        error
    end
    |> case do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Book added to Library successfully.")
        |> redirect(to: Routes.search_path(conn, :index, %{"query" => query}))

      {:error, _} ->
        conn
        |> put_flash(:info, "Failed to add Book to Library.")
        |> redirect(to: Routes.search_path(conn, :index, %{"query" => query}))
    end
  end

  def update(conn, %{"id" => id, "status" => new_status}) do
    profile = conn.assigns.current_profile
    new_status_atom = String.to_existing_atom(new_status)

    case Library.get_profile_book(id) do
      existing_pb when existing_pb.profile_id == profile.id ->
        Library.update_profile_book(existing_pb, %{status: new_status_atom})

        conn
        |> put_flash(:info, "Book status updated.")

      _ ->
        conn
        |> put_flash(:info, "Failed to update book status.")
    end
    |> redirect(to: Routes.profile_books_path(conn, :index))
  end

  def delete(conn, %{"id" => id}) do
    profile = conn.assigns.current_profile

    case Library.get_profile_book(id) do
      profile_book when profile_book.profile_id == profile.id ->
        Library.delete_profile_book(profile_book)

        conn
        |> put_flash(:info, "Book removed from Library.")

      _ ->
        conn
        |> put_flash(:info, "Failed to remove book from Library.")
    end
    |> redirect(to: Routes.profile_books_path(conn, :index))
  end

  defp convert_params_to_book(book_params, isbn_13) do
    %{
      isbn_13: isbn_13,
      title: book_params["volumeInfo"]["title"],
      subtitle: book_params["volumeInfo"]["subtitle"],
      google_api_id: book_params["id"],
      image_url: "https" <> String.trim_leading(book_params["volumeInfo"]["imageLinks"]["smallThumbnail"], "http"),
      authors: Enum.join(book_params["volumeInfo"]["authors"], ";")
    }
  end
end

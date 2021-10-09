defmodule ReadingListExWeb.BookController do
  use ReadingListExWeb, :controller

  alias ReadingListEx.Library
  alias ReadingListEx.Library.Book

  def index(conn, _params) do
    books = Library.list_books()
    render(conn, "index.html", books: books)
  end

  def new(conn, _params) do
    changeset = Library.change_book(%Book{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"book" => book_params}) do
    map = Map.merge(book_params, %{ "profile_id" => conn.assigns.current_profile.id }) |> IO.inspect
    case Library.create_book(map) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book created successfully.")
        |> redirect(to: Routes.book_path(conn, :show, book))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Library.get_book!(id)
    render(conn, "show.html", book: book)
  end

  def edit(conn, %{"id" => id}) do
    book = Library.get_book!(id)
    changeset = Library.change_book(book)
    render(conn, "edit.html", book: book, changeset: changeset)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Library.get_book!(id)

    case Library.update_book(book, book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book updated successfully.")
        |> redirect(to: Routes.book_path(conn, :show, book))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", book: book, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Library.get_book!(id)
    {:ok, _book} = Library.delete_book(book)

    conn
    |> put_flash(:info, "Book deleted successfully.")
    |> redirect(to: Routes.book_path(conn, :index))
  end
end

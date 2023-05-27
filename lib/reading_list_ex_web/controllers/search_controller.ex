defmodule ReadingListExWeb.SearchController do
  use ReadingListExWeb, :controller

  alias ReadingListEx.Library

  def index(conn, params) do
    profile = conn.assigns.current_profile

    case ReadingListEx.GoogleAPIHelper.query_books(params) do
      {:ok, body} ->
        render(conn, "index.html", books: set_book_in_library_flags(body["items"], profile))

      {:error, %{reason: reason}} ->
        {:error, reason}
    end
  end

  defp set_book_in_library_flags(books, nil), do: Enum.map(books, fn b -> Map.put(b, :in_library, false) end)

  defp set_book_in_library_flags(books, profile) do
    books_in_library =
      Library.get_profile_books_by_profile_and_google_ids(
        profile,
        Enum.map(books, fn b -> b["id"] end)
      )

    books
    |> Enum.map(fn b ->
      Map.put(b, :in_library, Enum.any?(books_in_library, &(&1 == b["id"])))
    end)
  end
end

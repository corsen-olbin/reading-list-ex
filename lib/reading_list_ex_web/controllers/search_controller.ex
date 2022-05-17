defmodule ReadingListExWeb.SearchController do
  use ReadingListExWeb, :controller

  def index(conn, params) do

    case ReadingListEx.GoogleAPIHelper.query_books(params) do
      {:ok, body} -> render(conn, "index.html", books: body)
      {:error, %{reason: reason}} -> {:error, reason}
    end
  end

end

defmodule ReadingListExWeb.SearchController do
  use ReadingListExWeb, :controller

  def index(conn, params) do
    query = :uri_string.compose_query([{"q", params["query"]}])

    case ReadingListEx.GoogleAPIHelper.query_books(query) do
      {:ok, %HTTPoison.Response{status_code: _code, body: body}} -> render(conn, "index.html", books: decode(body))
      {:error, %{reason: reason}} -> {:error, reason}
    end
  end

  defp decode(body) do
    case Poison.decode(body) do
      {:ok, parsed} -> parsed
      _ -> body
    end
  end
end

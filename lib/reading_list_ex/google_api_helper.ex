defmodule ReadingListEx.GoogleAPIHelper do
  def google_book_url, do: "https://www.googleapis.com/books/v1"

  def query_books(params) do
    query = :uri_string.compose_query([{"q", params["q"]}])
    execute_query("#{google_book_url()}/volumes?#{query}")
  end

  def query_book(book_id) do
    execute_query("#{google_book_url()}/volumes/#{book_id}")
  end

  def execute_query(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: _code, body: body}} -> {:ok, decode(body)}
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

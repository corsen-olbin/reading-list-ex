defmodule ReadingListEx.GoogleAPIHelper do

  def google_book_url, do: "https://www.googleapis.com/books/v1"

  def query_books(query) do
    HTTPoison.get("#{google_book_url()}/volumes?#{query}")
  end

  def query_book(book_id) do
    HTTPoison.get("#{google_book_url()}/volumes/#{book_id}")
  end
end

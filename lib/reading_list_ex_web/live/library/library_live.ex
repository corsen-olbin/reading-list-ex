defmodule ReadingListExWeb.LibraryLive do
  use ReadingListExWeb, :live_view
  on_mount ReadingListExWeb.UserLiveAuth

  def mount(_params, _session, socket), do: {:ok, socket }

  def handle_params(_params, _url, socket) do
    {:noreply, assign_books(socket)}
  end

  alias ReadingListEx.Library

  def assign_books(socket) do
    profile = socket.assigns.current_profile

    books = Library.get_profile_books_by_profile(profile)
    assign(socket, :books, books)
  end

  def separate_author_names(nil), do: ""

  def separate_author_names(authors_string) do
    authors_string
    |> String.split(";")
    |> Enum.join(", ")
  end

  def change_to_https(nil), do: ""
  def change_to_https("http://" <> rest_url), do: "https://#{rest_url}"
  def change_to_https(url), do: url
end

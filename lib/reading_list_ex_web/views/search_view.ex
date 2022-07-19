defmodule ReadingListExWeb.SearchView do
  use ReadingListExWeb, :view

  def join_author_names(nil), do: ""
  def join_author_names([]), do: ""
  def join_author_names(authors_list) do
    authors_list
    |> Enum.join(", ")
  end

  def change_to_https("http://" <> rest_url), do: "https://" <> rest_url
  def change_to_https(url), do: url
end

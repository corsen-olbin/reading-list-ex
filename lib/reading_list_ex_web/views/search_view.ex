defmodule ReadingListExWeb.SearchView do
  use ReadingListExWeb, :view

  def join_author_names(nil), do: ""
  def join_author_names([]), do: ""
  def join_author_names(authors_list) do
    authors_list
    |> Enum.join(", ")
  end
end

defmodule ReadingListExWeb.ProfileBooksView do
  use ReadingListExWeb, :view

  def separate_author_names(nil), do: ""
  def separate_author_names(authors_string) do
    authors_string
    |> String.split(";")
    |> Enum.join(", ")
  end
end

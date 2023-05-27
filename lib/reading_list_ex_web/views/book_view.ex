defmodule ReadingListExWeb.BookView do
  use ReadingListExWeb, :view

  def change_to_https("http://" <> rest_url), do: "https://" <> rest_url
  def change_to_https(url), do: url
end

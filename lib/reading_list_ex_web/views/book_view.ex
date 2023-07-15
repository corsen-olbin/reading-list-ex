defmodule ReadingListExWeb.BookView do
  use ReadingListExWeb, :view

  def change_to_https("http://" <> rest_url), do: "https://" <> rest_url
  def change_to_https(url), do: url

  def build_genre_tree(genre_list) do
    genre_list
    |> TreeFunctions.create_tree()
    |> convert_tree_to_ul()
  end

  def convert_tree_to_ul(tree) do
    raw("<ul class=\"list-disc list-inside\">" <> convert_tree_to_ul_rec(tree) <> "</ul>")
  end

  def convert_tree_to_ul_rec([]) do
    ""
  end

  def convert_tree_to_ul_rec([ %TreeNode{name: genre, children: []} | rest]) do
    "<li><a href=\"/search?q=subject:#{genre}\">#{genre}</a></li>" <> convert_tree_to_ul_rec(rest)
  end

  def convert_tree_to_ul_rec([ %TreeNode{name: genre, children: children} | rest]) do
    "<li><a href=\"/search?q=subject:#{genre}\">#{genre}</a><ul class=\"list-disc list-inside ml-4\">" <> convert_tree_to_ul_rec(children) <> "</ul></li>" <> convert_tree_to_ul_rec(rest)
  end


end

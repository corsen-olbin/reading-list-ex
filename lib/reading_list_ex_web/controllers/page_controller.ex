defmodule ReadingListExWeb.PageController do
  use ReadingListExWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

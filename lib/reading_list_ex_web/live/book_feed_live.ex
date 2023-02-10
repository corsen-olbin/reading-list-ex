defmodule ReadingListExWeb.BookFeedLive do
  use ReadingListExWeb, :live_view

  @topic "books:live"

  def render(assigns) do
    Phoenix.View.render(MyAppWeb.PageView, "page.html", assigns)
  end

  def mount(_params, _session, socket) do
    ReadingListExWeb.Endpoint.subscribe("books:live")

    {:ok, assign(socket, books: [])}
  end

  def handle_info(%{topic: @topic, payload: state}, socket) do
    IO.puts "HANDLE BROADCAST FOR #{state[:status]}"
    {:noreply, assign(socket, state)}
  end
end

defmodule ReadingListExWeb.BookFeedLive do
  use ReadingListExWeb, :live_view

  @topic "books:live"

  def render(assigns) do
    ~H"""
    <h1>Books</h1>
    <table>

      <tbody>
      <%= for book <- @books do %>
        <tr>
          <td><%= book.body %></td>
        </tr>
      <% end %>
      </tbody>
    </table>
    """
  end

  def mount(_params, _session, socket) do
    ReadingListExWeb.Endpoint.subscribe(@topic)

    {:ok, assign(socket, books: [])}
  end

  def handle_info(%{topic: @topic, payload: state}, socket) do
    IO.puts "HANDLE BROADCAST FOR #{state.body}"
    {:noreply, assign(socket, books: [state | socket.assigns.books])}
  end
end

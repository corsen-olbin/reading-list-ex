defmodule ReadingListExWeb.BookFeedLive do
  use ReadingListExWeb, :live_view

  @topic "books:live"
  @time_to_update 3

  def render(assigns) do
    ~H"""
    <h1>Books</h1>

      <ul>
      <%= for book <- @books do %>
        <li class="list_item" mod-first={@mod_first == book.state.body} mod-last={@mod_last == book.state.body}><%= book.state.body %></li>
      <% end %>
      </ul>
    """
  end

  def mount(_params, _session, socket) do
    ReadingListExWeb.Endpoint.subscribe(@topic)

    {:ok, assign(socket, books: [])}
  end

  def handle_info(%{topic: @topic, payload: state}, socket) do
    now = DateTime.utc_now()
    { add_transitions, new_books } = case socket.assigns.books do
      [] -> { true, [%{state: state, time: now}] }
      list -> add_new_book_if_time_passed(list, state)
    end
    socket = if add_transitions, do: add_transitions_tags(socket, new_books), else: socket
    {:noreply, assign(socket, books: new_books)}
  end

  defp add_new_book_if_time_passed(list = [head | _], new_state) do
    now = DateTime.utc_now()
    cond do
      DateTime.diff(now, head.time) > @time_to_update ->
        remaining = Enum.take(list, 5)
        { true, [%{ state: new_state, time: now } | remaining] }

      true -> { false, list }
    end
  end

  defp add_transitions_tags(socket, books) do
    get_body_at_index = fn books, x -> Enum.at(books, x, %{}) |> Map.get(:state, %{}) |> Map.get(:body) end
    socket
    |> assign(:mod_first, get_body_at_index.(books, 0))
    |> assign(:mod_last, get_body_at_index.(books, 5))
  end
end

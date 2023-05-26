defmodule ReadingListExWeb.BookFeedLive do
  use ReadingListExWeb, :live_view

  # alias Phoenix.LiveView.JS

  @topic "books:live"
  @time_to_update 1

  def render(assigns) do
    ~H"""
    <h1>Books</h1>

      <ul>
      <%= for book <- @books do %>
        <!--<li id={book.state.uid} data-fadein={animate_fade_in("#" <> book.state.uid)} phx-remove={JS.hide(transition: "animate-fadeout", to: "#" <> book.state.uid, time: 500)}><%= book.state.title %></li> -->
        <li id={book.state.uid}><%= book.state.title %></li>
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
    { _add_transitions, new_books } = case socket.assigns.books do
      [] -> { true, [%{state: state, time: now}] }
      list -> add_new_book_if_time_passed(list, state)
    end
    # socket = if add_transitions, do: add_transitions_tags(socket, new_books), else: socket
    {:noreply, assign(socket, books: new_books)}
  end

  defp add_new_book_if_time_passed(list = [head | _], new_state) do
    now = DateTime.utc_now()
    cond do
      DateTime.diff(now, head.time) > @time_to_update ->
        remaining = Enum.take(list, 4)
        { true, [%{ state: new_state, time: now } | remaining] }

      true -> { false, list }
    end
  end

  # defp add_transitions_tags(socket, books) do
  #   get_id_at_index = fn books, x -> Enum.at(books, x, %{}) |> Map.get(:state, %{}) |> Map.get(:uid) end
  #   socket
  #   |> push_event("fadein", %{id: get_id_at_index.(books, 0)})
  #   # |> push_event("fadeout", %{id: get_id_at_index.(books, 5)})
  # end

  # def animate_fade_in(element_id) do
  #   JS.transition("animate-fadein", to: element_id, time: 600)
  # end

  # def animate_fade_out(element_id) do
  #   JS.transition("animate-fadeout", to: element_id, time: 600)
  # end
end

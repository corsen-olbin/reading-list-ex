defmodule ReadingListExWeb.PageLive do
  use Phoenix.LiveView
  use Phoenix.HTML

  alias ReadingListEx.Library
  # alias Phoenix.LiveView.JS

  @topic "books:live"
  @time_to_update 5

  def mount(_params, _session, socket) do
    ReadingListExWeb.Endpoint.subscribe(@topic)
    now = DateTime.utc_now()
    new_5_books = Library.get_newest_5_profile_books()
     |> Enum.map(fn pb -> %{state: %{uid: pb.book.google_api_id, title: pb.book.title}, time: now} end)
    {:ok, assign(socket, books: new_5_books)}
  end

  def handle_info(%{topic: @topic, payload: state}, socket) do
    now = DateTime.utc_now()

    {_add_transitions, new_books} =
      case socket.assigns.books do
        [] -> {true, [%{state: state, time: now}]}
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
        {true, [%{state: new_state, time: now} | remaining]}

      true ->
        {false, list}
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

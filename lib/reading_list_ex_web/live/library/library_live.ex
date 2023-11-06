defmodule ReadingListExWeb.LibraryLive do
  use ReadingListExWeb, :live_view
  on_mount ReadingListExWeb.UserLiveAuth

  def mount(_params, _session, socket), do: {:ok, socket }

  def handle_params(params, _url, socket) do
    socket =
      socket
      |> parse_params(params)
      |> assign_books()

    {:noreply, socket}
  end

  def handle_info({:update, opts}, socket) do
    path = Routes.live_path(socket, __MODULE__, opts)
    {:noreply, push_patch(socket, to: path, replace: true)}
  end

  alias ReadingListEx.Library

  alias ReadingListExWeb.Forms.SortingForm

  def parse_params(socket, params) do
    with {:ok, sorting_opts} <- SortingForm.parse(params) do
      assign_sorting(socket, sorting_opts)
    else
      _error ->
        assign_sorting(socket)
    end
  end

  def assign_sorting(socket, overrides \\ %{}) do
    opts = Map.merge(SortingForm.default_values(), overrides)
    assign(socket, :sorting, opts)
  end

  def assign_books(socket) do
    profile = socket.assigns.current_profile
    %{sorting: sorting} = socket.assigns

    books = Library.get_library_records_by_profile(profile, sorting)
    assign(socket, :books, books)
  end

  def separate_author_names(nil), do: ""

  def separate_author_names(authors_string) do
    authors_string
    |> String.split(";")
    |> Enum.join(", ")
  end

  def change_to_https(nil), do: ""
  def change_to_https("http://" <> rest_url), do: "https://#{rest_url}"
  def change_to_https(url), do: url
end

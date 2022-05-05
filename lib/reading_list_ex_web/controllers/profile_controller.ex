defmodule ReadingListExWeb.ProfilesController do
  use ReadingListExWeb, :controller

  alias ReadingListEx.Library

  def index(conn, _params) do
    profiles = Library.list_profiles()
    render(conn, "index.html", profiles: profiles)
  end

  def show(conn, %{"id" => id}) do
    profile = Library.get_profile!(id)
    render(conn, "show.html", profile: profile)
  end
end

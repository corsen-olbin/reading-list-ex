defmodule ReadingListExWeb.UserLiveAuth do
  import Phoenix.Component
  import Phoenix.LiveView
  alias ReadingListEx.{Accounts, Library}

  def on_mount(:default, _params, %{"user_token" => user_token} = _session, socket) do
    user = user_token && Accounts.get_user_by_session_token(user_token)
    profile = user && Library.get_profile_by_user(user)

    socket = socket
    |> assign(:current_user, user)
    |> assign(:current_profile, profile)

    if socket.assigns.current_user do
      {:cont, socket}
    else
      {:halt, redirect(socket, to: "/users/log_in")}
    end
  end
end

defmodule ReadingListExWeb.UserRegistrationController do
  use ReadingListExWeb, :controller

  alias ReadingListEx.Accounts
  alias ReadingListEx.Accounts.User
  alias ReadingListExWeb.UserAuth
  alias ReadingListEx.Library.Profile

  def new(conn, _params) do
    profile_changeset = Profile.changeset(%Profile{}, %{})
    changeset = Accounts.change_user_registration(%User{profile: profile_changeset})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(:info, "User created successfully.")
        |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end

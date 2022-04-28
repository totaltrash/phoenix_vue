defmodule MyAppWeb.AuthController do
  use MyAppWeb, :controller

  alias MyApp.Accounts
  alias MyAppWeb.UserAuth

  def login_form(conn, _params) do
    render(conn, "login_form.html", error_message: nil)
  end

  def login(conn, %{"user" => user_params}) do
    Accounts.User
    |> Ash.Query.for_read(:by_username_and_password, user_params)
    |> Accounts.read_one()
    |> case do
      {:ok, %MyApp.Accounts.User{} = user} ->
        UserAuth.log_in_user(conn, user, user_params)

      _ ->
        render(conn, "login_form.html", error_message: "Invalid username or password")
    end
  end

  def logout(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully")
    |> UserAuth.log_out_user()
  end
end

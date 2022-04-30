defmodule Test.Feature.Auth.LoginTest do
  use Test.FeatureCase

  @moduletag :wip
  @moduletag login: false

  feature "successful login", %{session: session, user: user, raw_password: raw_password} do
    session
    |> visit(login_route())
    |> assert_has(login_form())
    |> fill_form(user.username, raw_password)
    |> assert_has(page_header("Home"))
  end

  @tag user: [username: "BAMMO", password: "CHOMPY"]
  feature "login with tags overriding user defaults", %{
    session: session,
    user: user,
    raw_password: raw_password
  } do
    session
    |> visit(login_route())
    |> fill_form(user.username, raw_password)
    |> assert_has(page_header("Home"))
  end

  feature "login and redirect", %{session: session, user: user, raw_password: raw_password} do
    session
    |> visit(page_route())
    |> assert_has(login_form())
    |> fill_form(user.username, raw_password)
    |> assert_has(page_header("Some Page"))
  end

  feature "failed login invalid username", %{session: session} do
    session
    |> visit(login_route())
    |> fill_form("invalid", "whatever")
    |> assert_login_failed()
  end

  feature "failed login invalid password", %{session: session, user: user} do
    session
    |> visit(login_route())
    |> fill_form(user.username, "whatever")
    |> assert_login_failed()
  end

  @tag login: true
  feature "login automatically for tests", %{session: session} do
    session
    |> visit(home_route())
    |> assert_has(page_header("Home"))
  end

  defp login_route, do: Routes.auth_path(@endpoint, :login)
  defp home_route, do: Routes.client_path(@endpoint, :index)
  defp page_route, do: Routes.page_path(@endpoint, :index)
  defp login_form, do: Query.data("role", "login-form")

  defp assert_login_failed(session) do
    assert_has(session, Query.data("role", "login-form", text: "Invalid username or password"))
  end

  defp fill_form(session, username, password) do
    session
    |> fill_in(Query.text_field("Username"), with: username)
    |> fill_in(Query.text_field("Password"), with: password)
    |> click(Query.button("Sign in"))
  end
end

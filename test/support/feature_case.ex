defmodule Test.FeatureCase do
  @moduledoc """
  This module defines the test case to be used by features.
  """

  use ExUnit.CaseTemplate
  use Wallaby.DSL
  import Test.Factory
  alias MyAppWeb.Router.Helpers, as: Routes

  using do
    quote do
      use Wallaby.DSL
      import Wallaby.Feature
      import Test.Factory
      import Test.FeatureHelpers

      alias MyAppWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint MyAppWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(MyApp.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(MyApp.Repo, {:shared, self()})
    end

    context =
      %{}
      |> set_session_context()
      |> set_user_context(tags)
      |> do_login(tags)

    {:ok, context}
  end

  defp set_session_context(context) do
    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(MyApp.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)

    Map.put(context, :session, session)
  end

  defp set_user_context(context, tags) do
    if tags[:user] == false do
      context
    else
      {user, raw_password} =
        if tags[:user] != nil do
          insert(:user, Enum.into(tags[:user], %{with_raw_password: true}))
        else
          insert(:user, with_raw_password: true)
        end

      context
      |> Map.put(:user, user)
      |> Map.put(:raw_password, raw_password)
    end
  end

  defp do_login(%{session: session, user: user, raw_password: raw_password} = context, tags) do
    if tags[:login] == false do
      context
    else
      session =
        session
        |> visit(login_route())
        |> fill_form(user.username, raw_password)
        |> assert_home_page_loaded()

      Map.put(context, :session, session)
    end
  end

  defp do_login(context, _tags) do
    context
  end

  defp fill_form(session, username, password) do
    session
    |> fill_in(Query.text_field("Username"), with: username)
    |> fill_in(Query.text_field("Password"), with: password)
    |> click(Query.button("Sign in"))
  end

  defp assert_home_page_loaded(session) do
    assert_has(session, Query.data("role", "header-title", text: "Home"))
  end

  defp login_route, do: Routes.auth_path(MyAppWeb.Endpoint, :login)
end

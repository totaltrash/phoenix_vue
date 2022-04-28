defmodule Test.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use Test.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  import Test.Factory

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import Test.ConnCase
      import Test.Factory

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
      |> set_conn_context()
      |> set_user_context(tags)
      |> do_login(tags)

    {:ok, context}
  end

  defp set_conn_context(context) do
    Map.put(context, :conn, Phoenix.ConnTest.build_conn())
  end

  defp set_user_context(conn, tags) do
    if tags[:user] == false do
      conn
    else
      {user, raw_password} =
        if tags[:user] != nil do
          insert(:user, Enum.into(tags[:user], %{with_raw_password: true}))
        else
          insert(:user, with_raw_password: true)
        end

      conn
      |> Map.put(:user, user)
      |> Map.put(:raw_password, raw_password)
    end
  end

  defp do_login(context = %{conn: conn, user: user}, tags) do
    if tags[:login] == false do
      context
    else
      %{token: token} = insert(:user_token, user: user)

      conn =
        conn
        |> Phoenix.ConnTest.init_test_session(%{})
        |> Plug.Conn.put_session(:user_token, token)

      Map.put(context, :conn, conn)
    end
  end

  defp do_login(context, _tags) do
    context
  end
end

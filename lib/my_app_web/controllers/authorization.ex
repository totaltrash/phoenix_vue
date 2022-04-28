defmodule MyAppWeb.Authorization do
  import Plug.Conn
  import Phoenix.Controller

  def is_admin(conn, _opts) do
    if MyApp.Accounts.RoleChecker.has_role(conn.assigns[:current_user], :admin) do
      conn
    else
      conn
      |> put_root_layout(false)
      |> put_view(MyAppWeb.ErrorView)
      |> put_status(403)
      |> render(:"403")
      |> halt()
    end
  end
end

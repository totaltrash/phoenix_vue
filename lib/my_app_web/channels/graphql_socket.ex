defmodule MyAppWeb.GraphqlSocket do
  use Absinthe.GraphqlWS.Socket, schema: MyApp.Schema

  @impl true
  def handle_init(%{"token" => token}, socket) do
    user =
      MyApp.Accounts.User
      |> Ash.Query.for_read(:by_token, token: token, context: "session")
      |> MyApp.Accounts.read_one!()

    case user do
      %MyApp.Accounts.User{} = user ->
        socket = assign_context(socket, current_user: user)
        {:ok, %{}, socket}

      _ ->
        {:error, %{}, socket}
    end
  end
end

defmodule MyAppWeb.GraphqlSocket do
  use Absinthe.GraphqlWS.Socket, schema: MyApp.Schema
end

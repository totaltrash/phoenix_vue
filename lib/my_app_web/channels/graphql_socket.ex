defmodule MyAppWeb.GraphqlSocket do
  use Absinthe.GraphqlWS.Socket, schema: MyAppWeb.Schema
end

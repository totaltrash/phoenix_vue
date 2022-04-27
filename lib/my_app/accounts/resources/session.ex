defmodule MyApp.Accounts.Session do
  use Ash.Resource,
    data_layer: Ash.DataLayer.Ets

  attributes do
    attribute(:session_id, :binary, primary_key?: true, allow_nil?: false)
    attribute(:value, :map, default: %{})
    create_timestamp(:created_date)
    update_timestamp(:updated_date)
  end
end

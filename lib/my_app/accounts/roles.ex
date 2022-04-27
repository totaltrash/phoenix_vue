defmodule MyApp.Accounts.Roles do
  def all_roles() do
    [
      Administrator: :admin,
      User: :user
    ]
  end

  def get_title(key) do
    invert_roles()
    |> Keyword.get(key, "Unknown Role")
    |> to_string()
  end

  def get_titles(keys) do
    invert_roles()
    |> Enum.filter(fn {key, _label} -> Enum.member?(keys, key) end)
    |> Enum.map(fn {_key, label} -> label |> to_string() end)
  end

  defp invert_roles do
    all_roles()
    |> Enum.into([], fn {label, key} -> {key, label} end)
  end
end

defmodule MyApp.Accounts.RoleChecker do
  # def can(%MyApp.Accounts.User{} = user, :delete, %MyApp.Projects.FileNote{} = _file_note) do
  #   Enum.member?(user.roles, :admin)
  # end

  def can(_user, _do_something_to, _a_thing), do: false

  def has_role(%MyApp.Accounts.User{} = user, role) do
    Enum.member?(user.roles, role)
  end
end

defmodule MyApp.Accounts.User.Validations do
  alias MyApp.Accounts.User.Validations

  def validate_current_password(field) do
    {Validations.ValidateCurrentPassword, [field: field]}
  end
end

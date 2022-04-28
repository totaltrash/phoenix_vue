defmodule MyApp.Accounts.Registry do
  use Ash.Registry,
    extensions: [Ash.Registry.ResourceValidations]

  entries do
    entry(MyApp.Accounts.User)
    entry(MyApp.Accounts.UserToken)
    entry(MyApp.Accounts.Session)
    entry(MyApp.Accounts.Course)
  end
end

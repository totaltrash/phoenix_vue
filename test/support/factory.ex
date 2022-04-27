defmodule Test.Factory do
  def insert(_, attr \\ [])

  def insert(:user, attr) do
    unique_integer = System.unique_integer([:positive])

    attr =
      Enum.into(attr, %{
        username: "some#{unique_integer}",
        email: "some#{unique_integer}@email.com",
        first_name: "First#{unique_integer}",
        surname: "Surname#{unique_integer}",
        password: "SomeP@ss",
        with_raw_password: false,
        roles: [:user]
      })

    user =
      MyApp.Accounts.User
      |> Ash.Changeset.new()
      |> Ash.Changeset.set_arguments(%{
        password: attr.password,
        password_confirmation: attr.password
      })
      |> Ash.Changeset.for_create(:create, Map.drop(attr, [:password, :with_raw_password]))
      |> MyApp.Accounts.create!()
      |> MyApp.Accounts.load!([:full_name])
      |> field_to_string(:email)
      |> field_to_string(:username)

    if attr.with_raw_password do
      {user, attr.password}
    else
      user
    end
  end

  def insert(:user_token, attr) do
    %{user: user} = Enum.into(attr, %{user: nil})

    MyApp.Accounts.UserToken
    |> Ash.Changeset.new()
    |> Ash.Changeset.for_create(:build_session_token)
    |> Ash.Changeset.replace_relationship(:user, user)
    |> MyApp.Accounts.create!()
  end

  # convert ci_string (and other string wrapper types) to string
  defp field_to_string(item, field) do
    Map.put(item, field, to_string(Map.get(item, field)))
  end
end

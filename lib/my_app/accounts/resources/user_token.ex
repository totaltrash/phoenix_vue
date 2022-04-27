defmodule MyApp.Accounts.UserToken do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    notifiers: [MyApp.Accounts.EmailNotifier]

  alias MyApp.Accounts.UserToken.Changes
  alias MyApp.Accounts.Preparations

  postgres do
    table("user_token")
    repo(MyApp.Repo)
  end

  identities do
    identity(:token_context, [:context, :token])
  end

  actions do
    read(:read, primary?: true)

    read :verify_email_token do
      argument(:token, :url_encoded_binary, allow_nil?: false)
      argument(:context, :string, allow_nil?: false)
      prepare(Preparations.SetHashedToken)
      prepare(Preparations.DetermineDaysForToken)

      filter(
        expr do
          token == ^context(:hashed_token) and context == ^arg(:context) and
            created_date > ago(^context(:days_for_token), :day)
        end
      )
    end

    create :build_session_token do
      primary?(true)
      accept([:user])

      change(set_attribute(:context, "session"))
      change(Changes.BuildSessionToken)
    end

    create :build_email_token do
      accept([:sent_to, :context, :user])

      change(Changes.BuildHashedToken)
    end
  end

  attributes do
    uuid_primary_key(:id)

    attribute(:token, :binary)
    attribute(:context, :string)
    attribute(:sent_to, :string)

    create_timestamp(:created_date)
  end

  relationships do
    belongs_to :user, MyApp.Accounts.User, required?: true
  end
end

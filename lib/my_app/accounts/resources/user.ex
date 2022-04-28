defmodule MyApp.Accounts.User do
  use Ash.Resource, data_layer: AshPostgres.DataLayer

  import MyApp.Accounts.User.Validations

  alias MyApp.Accounts.Preparations
  alias MyApp.Accounts.User.Preparations, as: UserPreparations
  alias MyApp.Accounts.User.Changes

  identities do
    identity(:unique_email, [:email], message: "Email already exists")
    identity(:unique_username, [:username], message: "Username already exists")
  end

  postgres do
    table("user")
    repo(MyApp.Repo)
  end

  actions do
    read :read do
      primary?(true)
      prepare(build(sort: [username: :asc], load: [:full_name]))
    end

    read :by_username do
      argument(:username, :string, allow_nil?: false, sensitive?: true)
      prepare(build(load: [:full_name]))
      filter(expr(username == ^arg(:username)))
    end

    read :by_username_and_password do
      argument(:username, :string, allow_nil?: false, sensitive?: true)
      argument(:password, :string, allow_nil?: false, sensitive?: true)

      prepare(UserPreparations.ValidatePassword)
      prepare(build(load: [:full_name]))

      filter(expr(username == ^arg(:username)))
    end

    read :by_token do
      argument(:token, :url_encoded_binary, allow_nil?: false)
      argument(:context, :string, allow_nil?: false)
      prepare(Preparations.DetermineDaysForToken)
      prepare(build(load: [:full_name]))

      filter(
        expr do
          token.token == ^arg(:token) and token.context == ^arg(:context) and
            token.created_date > ago(^context(:days_for_token), :day)
        end
      )
    end

    read :with_verified_email_token do
      argument(:token, :url_encoded_binary, allow_nil?: false)
      argument(:context, :string, allow_nil?: false)

      prepare(Preparations.SetHashedToken)
      prepare(Preparations.DetermineDaysForToken)

      filter(
        expr do
          token.created_date > ago(^context(:days_for_token), :day) and
            token.token == ^context(:hashed_token) and token.context == ^arg(:context) and
            token.sent_to == email
        end
      )
    end

    create :create do
      accept([:username, :email, :first_name, :surname, :roles])

      argument(:password, :string,
        allow_nil?: false,
        constraints: [
          max_length: 80,
          min_length: 6
        ]
      )

      argument(:password_confirmation, :string, allow_nil?: false)

      validate(confirm(:password, :password_confirmation),
        message: "Password confirmation does not match"
      )

      change(Changes.HashPassword)
    end

    update :update do
      accept([:username, :email, :first_name, :surname, :roles])

      primary?(true)
    end

    update :deliver_user_confirmation_instructions do
      accept([])

      argument :confirmation_url_fun, :function do
        constraints(arity: 1)
        allow_nil?(false)
      end

      validate(attribute_equals(:confirmed_at, nil), message: "already confirmed")
      change(Changes.CreateEmailConfirmationToken)
    end

    update :deliver_update_email_instructions do
      accept([:email])

      argument(:current_password, :string, allow_nil?: false)

      argument :update_url_fun, :function do
        constraints(arity: 1)
        allow_nil?(false)
      end

      validate(validate_current_password(:current_password))
      validate(changing(:email))

      change(prevent_change(:email))
      change(Changes.CreateEmailUpdateToken)
    end

    update :deliver_user_reset_password_instructions do
      accept([])

      argument :reset_password_url_fun, :function do
        constraints(arity: 1)
        allow_nil?(false)
      end

      change(Changes.CreateResetPasswordToken)
    end

    update :logout do
      accept([])

      change(Changes.RemoveAllTokens)
    end

    update :change_email do
      accept([])
      argument(:token, :url_encoded_binary)

      change(Changes.GetEmailFromToken)
      change(Changes.DeleteEmailChangeTokens)
    end

    update :change_password do
      accept([])

      argument(:password, :string,
        allow_nil?: false,
        constraints: [
          max_length: 80,
          min_length: 6
        ]
      )

      argument(:password_confirmation, :string, allow_nil?: false)
      argument(:current_password, :string)

      validate(confirm(:password, :password_confirmation),
        message: "Does not match your new password"
      )

      validate(validate_current_password(:current_password))

      change(Changes.HashPassword)
      # change Changes.RemoveAllTokens
    end

    update :admin_change_password do
      accept([])

      argument :password, :string do
        allow_nil?(false)

        constraints(
          max_length: 80,
          min_length: 6
        )
      end

      argument :password_confirmation, :string do
        allow_nil?(false)
      end

      validate(confirm(:password, :password_confirmation),
        message: "Does not match new password"
      )

      change(Changes.HashPassword)
      # change Changes.RemoveAllTokens
    end

    update :confirm do
      accept([])
      argument(:delete_confirm_tokens, :boolean, default: false)

      change(set_attribute(:confirmed_at, &DateTime.utc_now/0))
      change(Changes.DeleteConfirmTokens)
    end
  end

  attributes do
    uuid_primary_key(:id)

    attribute :username, :ci_string do
      allow_nil?(false)
      constraints(max_length: 30)
    end

    attribute :email, :ci_string do
      allow_nil?(false)
      constraints(max_length: 160)
    end

    attribute :first_name, :string do
      allow_nil?(false)
      constraints(max_length: 50)
    end

    attribute :surname, :string do
      allow_nil?(false)
      constraints(max_length: 50)
    end

    attribute :roles, {:array, :atom} do
      allow_nil?(false)
      default([])
      constraints(nil_items?: false)
    end

    attribute(:confirmed_at, :utc_datetime_usec)

    attribute :hashed_password, :string do
      private?(true)
    end

    create_timestamp(:created_date)
    update_timestamp(:updated_date)
  end

  relationships do
    has_many :token, MyApp.Accounts.UserToken do
      destination_field(:user_id)
      private?(true)
    end
  end

  calculations do
    # with built in calculation
    # calculate(:full_name, :string, concat([:first_name, :surname], " "))

    # with expression
    # calculate(:full_name, :string, expr(first_name <> " " <> surname))

    # with fragment using concat operator
    # calculate(:full_name, :string, expr(fragment("first_name || ' ' || surname")))

    # with fragment using concat_ws function
    calculate(:full_name, :string, expr(fragment("concat_ws(' ', ?, ?)", first_name, surname)))
  end

  validations do
    validate(match(:email, ~r/^[^\s]+@[^\s]+$/, "Must be in the format of an email address"))
  end
end

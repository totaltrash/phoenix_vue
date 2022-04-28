defmodule MyApp.Accounts.Course do
  use Ash.Resource, data_layer: AshPostgres.DataLayer

  postgres do
    table("course")
    repo(MyApp.Repo)
  end

  actions do
    read :read do
      primary?(true)
      prepare(build(load: [:full_title]))
    end
  end

  attributes do
    uuid_primary_key(:id)

    attribute :code, :string do
      allow_nil?(false)
      constraints(max_length: 50)
    end

    attribute :title, :string do
      allow_nil?(false)
      constraints(max_length: 50)
    end
  end

  calculations do
    calculate(:full_title, :string, concat([:code, :title], " "))
  end
end

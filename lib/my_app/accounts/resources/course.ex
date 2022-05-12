defmodule MyApp.Accounts.Course do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [
      AshGraphql.Resource
    ]

  postgres do
    table("course")
    repo(MyApp.Repo)
  end

  actions do
    read :read do
      primary?(true)
      prepare(build(load: [:full_title], sort: [:code]))
      pagination(offset?: true, required?: false)
    end
  end

  attributes do
    uuid_primary_key(:id)

    attribute :code, :string do
      allow_nil?(false)
      constraints(max_length: 50)
    end

    attribute :title, :string do
      allow_nil?(true)
      constraints(max_length: 255)
    end
  end

  calculations do
    # calculate(:full_title, :string, concat([:code, :title], " "))
    calculate(:full_title, :string, expr(code <> " " <> title))
  end

  graphql do
    type(:course)

    queries do
      # create a field called `get_course` that uses the read action to fetch a single course
      get(:get_course, :read)

      # create a field called `list_courses` that uses the read action to fetch a list of courses
      list(:list_courses, :read)
    end

    # mutations do
    #   # And so on
    #   create :create_course, :create
    #   update :update_course, :update
    #   destroy :destroy_course, :destroy
    # end
  end
end

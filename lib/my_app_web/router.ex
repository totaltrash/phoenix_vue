defmodule MyAppWeb.Router do
  use MyAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_root_layout, false
    plug :put_layout, false
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug :fetch_instance_config
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Login, other non authenticated pages
  pipeline :public do
    plug :put_root_layout, {MyAppWeb.LayoutView, :root_public}
    plug :put_layout, {MyAppWeb.LayoutView, :app}
  end

  # Authenticated, non-vue pages
  pipeline :app do
    plug :put_root_layout, {MyAppWeb.LayoutView, :root_app}
    plug :put_layout, {MyAppWeb.LayoutView, :app}
  end

  # Authenticated, vue client
  pipeline :client do
    plug :put_root_layout, {MyAppWeb.LayoutView, :root_client}
    plug :put_layout, false
  end

  scope "/", MyAppWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated, :public]

    get "/login", AuthController, :login_form
    post "/login", AuthController, :login
  end

  scope "/", MyAppWeb do
    pipe_through :browser

    get "/logout", AuthController, :logout
  end

  scope "/", MyAppWeb do
    pipe_through [:browser, :require_authenticated_user, :app]

    get "/", PageController, :index
  end

  scope "/", MyAppWeb do
    pipe_through [:browser, :require_authenticated_user, :client]

    get "/client/*client_path", ClientController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", MyAppWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MyAppWeb.Telemetry
    end
  end

  # Enables Graphiql playground for development
  if Mix.env() in [:dev, :test] do
    scope "/" do
      # forward "/gql", Absinthe.Plug, schema: MyApp.Schema

      forward "/playground",
              Absinthe.Plug.GraphiQL,
              schema: MyApp.Schema,
              interface: :playground
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  def fetch_instance_config(conn, _opts) do
    conn
    |> assign(:instance_name, Application.fetch_env!(:my_app, :instance_name))
  end
end

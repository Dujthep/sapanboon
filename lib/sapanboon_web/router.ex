defmodule SapanboonWeb.Router do
  use SapanboonWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SapanboonWeb.Plugs.SetUser
    plug Phoenix.LiveView.Flash
  end

  pipeline :api do
    plug CORSPlug, origin: "*",
    allow_methods: :all,
    allow_headers: :all,
    allow_credentials: true
    plug :accepts, ["json"]
  end

  scope "/api", SapanboonWeb do
    pipe_through :api
    post "/project", ProjectsController, :create
    put "/project", ProjectsController, :update
    delete "/project:id", ProjectsController, :delete
    put "/transaction", HistoryController, :update
    post "/transaction", HistoryController, :create
    post "/user", LoginController, :create
  end

  scope "/crontab", SapanboonWeb do
    put "/active", CrontabController, :active
    put "/complete", CrontabController, :complete
    put "/expire", CrontabController, :expire
  end

  scope "/", SapanboonWeb do
    pipe_through :browser
    get "/", ProjectsController, :index
    get "/abouts", AboutController, :index
    get "/admin", LoginController, :admin
    get "/contact", ContactController, :index
    get "/details/:id", ProjectsController, :detail
    get "/details/:id/payment", PaymentController, :index
    get "/history", HistoryController, :index
    get "/load_more", ProjectsController, :load_more
    get "/login", LoginController, :index
    get "/transaction/:id", ProjectsController, :create_transaction
    get "/search", ProjectsController, :search
    get "/success/:id", SuccessController, :index
  end

  scope "/auth", SapanboonWeb do
    pipe_through :browser
    get "/signout", LoginController, :delete
    get "/:provider", LoginController, :request
    get "/:provider/callback", LoginController, :callback
  end

end

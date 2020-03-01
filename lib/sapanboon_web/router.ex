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
    plug :accepts, ["json"]
  end

  scope "/api", SapanboonWeb.Api do
    pipe_through :api
    get "/project", ProjectController, :index
    post "/project", ProjectController, :create
    delete "/project:id", ProjectController, :delete
    put "/project", ProjectController, :update
  end

  scope "/", SapanboonWeb do
    pipe_through :browser
    get "/", ProjectsController, :index
    get "/details/:id", ProjectsController, :detail
    get "/details/:id/payment", PaymentController, :index
    get "/transaction/:id", ProjectsController, :insert_transaction
    get "/abouts", AboutController, :index
    get "/contact", ContactController, :index
    get "/login", LoginController, :index
    get "/history", HistoryController, :index
    get "/success/:id", SuccessController, :index
    put "/update_transaction", HistoryController, :update_transaction
    get "/load_more", ProjectsController, :load_more
  end

  scope "/auth", SapanboonWeb do
    pipe_through :browser
    get "/signout", LoginController, :delete
    get "/:provider", LoginController, :request
    get "/:provider/callback", LoginController, :callback
  end
  # Other scopes may use custom stacks.
  # scope "/api", SapanboonWeb do
  #   pipe_through :api
  # end
end

defmodule SapanboonWeb.Router do
  use SapanboonWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SapanboonWeb.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SapanboonWeb do
    pipe_through :browser
    get "/", ProjectsController, :index
    get "/details/:id", ProjectsController, :detail
    get "/details/:id/payment", PaymentController, :index
    get "/abouts", AboutController, :index
    get "/contact", ContactController, :index
    get "/login", LoginController, :index
    get "/history", HistoryController, :index
    get "/success/:id", SuccessController, :index
    put "/cancel_trans", HistoryController, :cancel_trans
  end

  scope "/auth", SapanboonWeb do 
    pipe_through :browser
    get "/:provider", LoginController, :request
    get "/:provider/callback", LoginController, :callback
  end
  # Other scopes may use custom stacks.
  # scope "/api", SapanboonWeb do
  #   pipe_through :api
  # end
end

defmodule SapanboonWeb.LoginController do
  use SapanboonWeb, :controller
  plug(Ueberauth)

  alias Sapanboon.{Repo, User}
  # alias Sapanboon.SapanboonWeb.Login

  def index(conn, _params) do
    render(conn, "index.html", login: "")
  end

  # def request(conn, _params) do
  #   render(conn, "index.html", callback_url: Helpers.callback_url(conn))
  # end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do 
    IO.inspect(auth);
    user_params = %{
      token: auth.credentials.token,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      email: auth.info.email,
      provider: "google"
    }

    changeset = User.changeset(%User{}, user_params)
  end

end

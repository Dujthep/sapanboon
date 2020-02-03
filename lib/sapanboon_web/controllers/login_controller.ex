defmodule SapanboonWeb.LoginController do
  use SapanboonWeb, :controller
  plug(Ueberauth)

  alias Sapanboon.{Repo, User}
  # alias Sapanboon.SapanboonWeb.Login

  def index(conn, _params) do
    render(conn, "index.html", login: "")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{
      token: auth.credentials.token,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      email: auth.info.email,
      provider: conn.path_params["provider"],
      uid: auth.uid,
      name: auth.info.name,
      role: "user"
    }
    changeset = User.changeset(%User{}, user_params)
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.projects_path(conn, :index))
    {:error, _reason} ->
        conn
        |> put_flash(:error, "error signing in")
        |> redirect(to: Routes.login_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email, provider: changeset.changes.provider) do
      nil ->
        Repo.insert(changeset)

      user ->
        {:ok, user}
    end
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: Routes.projects_path(conn, :index))
  end
end

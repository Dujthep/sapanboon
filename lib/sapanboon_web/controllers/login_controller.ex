defmodule SapanboonWeb.LoginController do
  use SapanboonWeb, :controller
  plug(Ueberauth)

  alias Sapanboon.{Repo, User}
  # alias Sapanboon.SapanboonWeb.Login

  def index(conn, _params) do
    render(conn, "index.html", login: "", meta_attrs: [])
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{
      token: auth.credentials.token,
      email: auth.info.email,
      provider: conn.path_params["provider"],
      uid: auth.uid,
      name: auth.info.name,
      role: "user"
    }

    # post_params = user_params |> Poison.encode!()
    # url = Application.fetch_env!(:sapanboon, :api_transaction)

    # case HTTPoison.post(url <> "/user/insertUser", post_params, %{
    #        "Content-Type" => "application/json"
    #      }) do
    #   {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
    #     body = Poison.Parser.parse!(body)
    #     IO.inspect(body)

    #   {:error, _reason} ->
    #     IO.inspect(:error)
    # end

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

  def create(conn, params) do
    changeset = User.changeset(%User{}, params)

    case Repo.insert(changeset) do
      {:ok, login} ->
        conn
        |> put_status(:ok)
        |> render("show.json", login: login)

      {:error, %{errors: errors}} ->
        conn
        |> put_status(422)
        |> render(SapanboonWeb.ErrorView, "422.json")
    end
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: Routes.projects_path(conn, :index))
  end

  def admin(conn, _params) do
    url = Enum.join([Application.fetch_env!(:sapanboon, :admin_page), conn.assigns.user.uid])
    redirect(conn, external: url)
  end
end

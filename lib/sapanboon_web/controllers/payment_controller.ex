defmodule SapanboonWeb.PaymentController do
  use SapanboonWeb, :controller

  alias Sapanboon.Project
  alias Sapanboon.Histories
  alias Sapanboon.Histories.History

  def index(conn, %{"id" => id}) do
    history = Histories.get_history!(id)
    IO.inspect(history)
    render(conn, "index.html", history: history)
  end

  def update_transaction(conn, %{"id" => id,"image"=>image}) do
    
    history = Histories.get_history!(id)
    history_params = %{
      image_slip: image
    }

    case Histories.update_history(history,history_params) do
      {:ok, history} ->
        conn
        |> put_flash(:info, "History updated successfully.")
        |> redirect(to: Routes.success_path(conn, :index, id))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> redirect(to: Routes.payment_path(conn, :index, id))
    end

  end

end

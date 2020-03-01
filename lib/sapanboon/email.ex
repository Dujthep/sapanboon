defmodule Sapanboon.Email do
  use Bamboo.Phoenix, view: SapanboonWeb.EmailView
  require Logger

  defp base_email do
    new_email()
      |> from("Sapanboon")
      |> put_html_layout({SapanboonWeb.LayoutView, "email.html"})
  end

  def send_email(mail_user) do
    base_email()
      |> to(mail_user.email)
      |> from("Sapanboon")
      |> subject(mail_user.status)
      |> assign(:mail_user, mail_user)
      |> render("transaction.html")
  end

end

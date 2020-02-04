defmodule Sapanboon.Email do
  use Bamboo.Phoenix, view: SapanboonWeb.EmailView

  def send_email(email_address) do
    new_email()
    |> to(email_address)
    |> from("Sapanboon")
    |> subject("Welcome!")
    |> put_html_layout({Sapanboon.LayoutView, "email.html"})
    |> render("welcome.html")
  end

end

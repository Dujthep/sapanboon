defmodule Sapanboon.Email do
  use Bamboo.Phoenix, view: SapanboonWeb.EmailView

  defp base_email do
    new_email()
    |> from("Sapanboon")
    |> put_html_layout({SapanboonWeb.LayoutView, "email.html"})
  end

  def send_email_payment(email_address) do
    base_email()
    |> to(email_address)
    |> from("Sapanboon")
    |> subject("ยืนยันการบริจาค")
    |> assign(:email_address, email_address)
    |> render("payment.html")
  end

end

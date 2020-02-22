defmodule Sapanboon.Email do
  use Bamboo.Phoenix, view: SapanboonWeb.EmailView

  defp base_email do
    new_email()
      |> from("Sapanboon")
      |> put_html_layout({SapanboonWeb.LayoutView, "email.html"})
  end

  def send_email_payment(email_address) do
    mailUser = %{
      projectName: "โครงการทดสอบ",
      email: email_address,
      fullName: "Sothon Sitsiwalai",
      donation: "1,000",
      paymentType: "Prompay",
      transactionNo: "123",
      day: "10", month: "มกราคม", year: "2563", time: "10:00",
      project_id: "1"
    }
    base_email()
      |> to(email_address)
      |> from("Sapanboon")
      |> subject("ยืนยันการบริจาค")
      |> assign(:mailUser, mailUser)
      |> render("payment.html")
  end

end

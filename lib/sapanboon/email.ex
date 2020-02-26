defmodule Sapanboon.Email do
  use Bamboo.Phoenix, view: SapanboonWeb.EmailView
  require Logger

  defp base_email do
    new_email()
      |> from("Sapanboon")
      |> put_html_layout({SapanboonWeb.LayoutView, "email.html"})
  end

  def send_email_payment(value) do
    IO.inspect(value)

    email = value.email
    subject = value.subject
    mailUser = %{
      projectName: value.projectName,
      email: email,
      fullName: value.fullName,
      amount: value.amount,
      paymentType: value.paymentType,
      transactionNo: value.transactionNo,
      day: "10", month: "มกราคม", year: "2563", time: "10:00",
      project_id: value.project_id
    }
    base_email()
      |> to(email)
      |> from("Sapanboon")
      |> subject(subject)
      |> assign(:mailUser, mailUser)
      |> render("payment.html")
  end

end

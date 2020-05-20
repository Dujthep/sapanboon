defmodule Sapanboon.Email do
  use Bamboo.Phoenix, view: SapanboonWeb.EmailView
  require Logger

  defp base_email do
    new_email()
      |> from("Sapanboon")
      |> put_html_layout({SapanboonWeb.LayoutView, "email.html"})
  end

  def send_email(mail_user) do
    month = ["ม.ค.","ก.พ.","มี.ค.","เม.ย.","พ.ค.","มิ.ย.","ก.ค.","ส.ค.","ก.ย.","ต.ค.","พ.ย.","ธ.ค."]
    base_email()
      |> to(mail_user.email)
      |> from("Sapanboon")
      |> subject("โครงการ #{mail_user.projectName} : สถานะ #{mail_user.status}")
      |> assign(:mail_user, mail_user)
      |> assign(:month, month)
      |> render("transaction.html")
  end

  def send_email_test(mail_user) do
    month = ["ม.ค.","ก.พ.","มี.ค.","เม.ย.","พ.ค.","มิ.ย.","ก.ค.","ส.ค.","ก.ย.","ต.ค.","พ.ย.","ธ.ค."]
    base_email()
      |> to(mail_user.email)
      |> from("Sapanboon")
      |> subject("โครงการ #{mail_user.projectName} : สถานะ #{mail_user.status}")
      |> assign(:mail_user, mail_user)
      |> assign(:month, month)
      |> render("email.html")
  end

end

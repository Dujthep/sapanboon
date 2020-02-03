defmodule Sapanboon.Email do
  use Bamboo.Phoenix, view: Sapanboon.EmailView

  def send_email(email_address) do
    new_email()
    |> to(email_address)
    |> from("sapanboon.dev@gmail.com")
    |> subject("Welcome!")
    |> text_body("Welcome to MyApp!")
    |> put_text_layout({Sapanboon.LayoutView, "email.text"})
  end

end

defmodule Sapanboon.EmailTest do
  use ExUnit.Case

  test "send email" do
    dateTime = Calendar.DateTime.now! "Asia/Bangkok"
    mail_user = %{
      projectName: "Test Project name Mail",
      email: "test@mail.com",
      fullName: "Test Email",
      amount: 1000,
      paymentType: "Test PaymentType",
      transactionNo: 1,
      dateTime: dateTime,
      status: "รอตรวจสอบเอกสาร"
    }

    email = Sapanboon.Email.send_email(mail_user)

    assert email.to == mail_user.email
    assert email.from == "Sapanboon"
    assert email.subject =~ "โครงการ #{mail_user.projectName} : สถานะ #{mail_user.status}"
  end
end
defmodule Sapanboon.QRcode do

  def generateQRcode(amount, transactionId, projectCode) do

    token = getSCBToken()["data"]["tokenType"] <> " " <> getSCBToken()["data"]["accessToken"]
    uuid = Ecto.UUID.generate()
    url = "https://api-sandbox.partners.scb/partners/sandbox/v1/payment/qrcode/create"
    body = %{
      qrType: "PP",
      ppType: "BILLERID",
      ppId: "406242648868404",
      amount: amount,
      ref1: transactionId,
      ref2: projectCode,
      ref3: "QWS"
    }
    |> Poison.encode!()

    headers = %{
      "Content-Type": "application/json",
      authorization: token,
      resourceOwnerId: "l710fd5909bcb64676a0d58c9f4910a504",
      requestUId: uuid,
      "accept-language": "EN",
    }
    case HTTPoison.post(url, body, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Poison.decode!()

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
        IO.inspect(reason)
    end
  end

  def getSCBToken do

    uuid = Ecto.UUID.generate()
    url = "https://api-sandbox.partners.scb/partners/sandbox/v1/oauth/token"
    body = %{
      applicationKey: "l710fd5909bcb64676a0d58c9f4910a504",
      applicationSecret: "41b6f92fa6874e4bad0dfbda956735b6"
    }|> Poison.encode!()

    headers = %{
      "Content-Type": "application/json",
      resourceOwnerId: "l710fd5909bcb64676a0d58c9f4910a504",
      requestUId: uuid,
      "accept-language": "EN"
    }

    case HTTPoison.post(url, body, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Poison.decode!()

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
        IO.inspect(reason)
    end
  end

end

defmodule Sapanboon.QRcode do

  def generateQRcode(amount, transactionId, projectCode) do

    token = getSCBToken()["data"]["tokenType"] <> " " <> getSCBToken()["data"]["accessToken"]
    uuid = Ecto.UUID.generate()
    url = "https://api-sandbox.partners.scb/partners/sandbox/v1/payment/qrcode/create"
    body = %{
      qrType: "PP",
      ppType: "BILLERID",
      ppId: "633153421253554",
      amount: amount,
      ref1: transactionId,
      ref2: projectCode,
      ref3: "VJO"
    }
    |> Poison.encode!()

    headers = %{
      "Content-Type": "application/json",
      authorization: token,
      resourceOwnerId: "l726d98af10f0b446da083bfbfed746c3c",
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
    body = "{
      \"applicationKey\": \"l726d98af10f0b446da083bfbfed746c3c\",
      \"applicationSecret\": \"4de6cbeace2b4d5b94b62bdb645e6bcd\"
    }"

    headers = %{
      "Content-Type": "application/json",
      "resourceOwnerId": "l726d98af10f0b446da083bfbfed746c3c",
      "requestUId": uuid,
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

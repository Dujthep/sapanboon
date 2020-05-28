defmodule Sapanboon.QRcode do
  def generateQRcode(amount, transactionId, projectCode) do
    token = getSCBToken()["data"]["tokenType"] <> " " <> getSCBToken()["data"]["accessToken"]
    IO.puts(token)






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
      resourceOwnerId: "l726d98af10f0b446da083bfbfed746c3c",
      requestUId: uuid,
      "accept-language": "EN"
    }

    # iex> HTTPoison.post "https://api-sandbox.partners.scb/partners/sandbox/v1/oauth/token", "{
    #   \"applicationKey\": \"l726d98af10f0b446da083bfbfed746c3c\",
    #   \"applicationSecret\": \"4de6cbeace2b4d5b94b62bdb645e6bcd\"
    # }", %{
    #   "Content-Type": "application/json",
    #   "resourceOwnerId": "l726d98af10f0b446da083bfbfed746c3c",
    #   "requestUId": "128efc1a-9f3f-11ea-bb37-0242ac130002",
    #   "accept-language": "EN"
    # }

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

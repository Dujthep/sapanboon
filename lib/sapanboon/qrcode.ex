defmodule Sapanboon.QRcode do

  alias SapanboonWeb.HttpWrapper
  require Logger

  def generate_qr_code(amount, transactionNo, projectCode) do
    scb_token = get_scb_token()
    token = scb_token.data.tokenType <> " " <> scb_token.data.accessToken
    url = Application.fetch_env!(:sapanboon, :scb_payment)[:url_partners] <> "/payment/qrcode/create"
    body = %{
      qrType: "PP",
      ppType: "BILLERID",
      ppId: Application.fetch_env!(:sapanboon, :scb_payment)[:ppId],
      amount: amount,
      ref1: transactionNo,
      ref2: projectCode,
      ref3: "QWS"
    } |> Poison.encode!()

    headers = %{
      "Content-Type": "application/json",
      resourceOwnerId: Application.fetch_env!(:sapanboon, :scb_payment)[:resource_owner_id],
      requestUId: Ecto.UUID.generate(),
      authorization: token,
      "accept-language": "EN",
    }

    case HttpWrapper.post(url, body, headers) do
      {:ok, body} -> body
      {:error, reason} -> Logger.error("error generate_qr_code: #{inspect(reason)}")
    end

  end

  def get_scb_token() do
    url = Application.fetch_env!(:sapanboon, :scb_payment)[:url_partners] <> "/oauth/token"
    body = %{
      applicationKey: Application.fetch_env!(:sapanboon, :scb_payment)[:application_key],
      applicationSecret: Application.fetch_env!(:sapanboon, :scb_payment)[:application_secret]
    } |> Poison.encode!()

    headers = %{
      "Content-Type": "application/json",
      resourceOwnerId: Application.fetch_env!(:sapanboon, :scb_payment)[:resource_owner_id],
      requestUId: Ecto.UUID.generate(),
      "accept-language": "EN"
    }

    case HttpWrapper.post(url, body, headers) do
      {:ok, body} -> body
      {:error, reason} -> Logger.error("error get_scb_token: #{inspect(reason)}")
    end

  end

end

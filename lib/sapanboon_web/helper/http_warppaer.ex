defmodule SapanboonWeb.HttpWrapper do
  @http_adapter Application.get_env(:sapanboon, :http_adapter)

  def post(url, body, options) do
    url
    |> post_url(body, options)
    |> process_response_body(url)
  end

  defp post_url(url, body, options), do: @http_adapter.post(url, body, options)

  defp process_response_body({:ok, %HTTPoison.Response{status_code: status_code, body: body}}, _url)
    when status_code in [200, 201, 204],
    do: {:ok, parse_body(body)}

  defp process_response_body({:ok, %HTTPoison.Response{status_code: status_code, body: body, headers: headers}}, url) do
    {
      :error,
      %{
        status_code: status_code,
        body: parse_body(body),
        url: url
      }
    }
  end

  defp process_response_body({:error, %HTTPoison.Error{reason: {_, reason}}}, _url),
    do: {:error, reason}

  defp process_response_body({:error, %HTTPoison.Error{reason: reason}}, _url),
    do: {:error, reason}

  defp process_response_body({:error, reason}, _url),
    do: {:error, reason}

  defp parse_body(body) do
    with {:ok, body} <- Poison.Parser.parse(body, keys: :atoms) do
      body
    else
      _ -> body
    end
  end

end
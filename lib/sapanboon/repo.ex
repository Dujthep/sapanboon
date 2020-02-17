defmodule Sapanboon.Repo do
  use Ecto.Repo,
    otp_app: :sapanboon,
    adapter: Ecto.Adapters.Postgres
  use Paginator
end

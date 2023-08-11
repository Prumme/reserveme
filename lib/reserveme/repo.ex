defmodule Reserveme.Repo do
  use Ecto.Repo,
    otp_app: :reserveme,
    adapter: Ecto.Adapters.Postgres
end

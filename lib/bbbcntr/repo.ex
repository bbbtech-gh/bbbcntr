defmodule Bbbcntr.Repo do
  use Ecto.Repo,
    otp_app: :bbbcntr,
    adapter: Ecto.Adapters.Postgres
end

defmodule PaoReminder.Repo do
  use Ecto.Repo,
    otp_app: :pao_reminder,
    adapter: Ecto.Adapters.Postgres
end

defmodule PaoReminder.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias PaoReminder.Bot.Reminder

  @impl true
  def start(_type, _args) do
    bot_config = Application.fetch_env!(:pao_reminder, :bot_config)

    children = [
      # Start the Ecto repository
      PaoReminder.Repo,
      # Start the Telemetry supervisor
      PaoReminderWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PaoReminder.PubSub},
      # Start the Endpoint (http/https)
      PaoReminderWeb.Endpoint,
      # Start a worker by calling: PaoReminder.Worker.start_link(arg)
      # {PaoReminder.Worker, arg}
      {Telegram.Poller, bots: [{Reminder, bot_config}]}
      # Scheduler
      #      PaoReminder.Scheduler
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PaoReminder.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PaoReminderWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

defmodule PaoReminder.Bot.Commands do
  @moduledoc false

  def send_message do
    token = Application.fetch_env!(:pao_reminder, :token_bot)

    Telegram.Api.request(token, "sendMessage",
      chat_id: Application.fetch_env!(:pao_reminder, :chat_ids),
      text: "D:"
    )
  end
end

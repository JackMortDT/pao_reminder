defmodule PaoReminderWeb.PageController do
  use PaoReminderWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

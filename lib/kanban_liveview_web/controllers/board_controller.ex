defmodule KanbanLiveviewWeb.BoardController do
  use KanbanLiveviewWeb, :controller
  import Phoenix.LiveView.Controller

  def show(conn, %{"id" => id}) do
    live_render(conn, KanbanLiveviewWeb.PageLive, session: %{"board_id" => id})
  end
end

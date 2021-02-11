defmodule KanbanLiveview.Repo do
  use Ecto.Repo,
    otp_app: :kanban_liveview,
    adapter: Ecto.Adapters.Postgres
end

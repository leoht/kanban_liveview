defmodule KanbanLiveview.Repo.Migrations.CreateColumns do
  use Ecto.Migration

  def change do
    create table(:columns) do
      add :title, :string
      add :board_id, references(:boards, on_delete: :nothing)

      timestamps()
    end

    create index(:columns, [:board_id])
  end
end

defmodule KanbanLiveview.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :content, :string
      add :column_id, references(:columns, on_delete: :nothing)

      timestamps()
    end

    create index(:cards, [:column_id])
  end
end

defmodule KanbanLiveview.Board do
  use Ecto.Schema
  import Ecto.Changeset

  schema "boards" do
    field :title, :string
    has_many :columns, KanbanLiveview.Column

    timestamps()
  end

  def find(id) do
    case KanbanLiveview.Board |> KanbanLiveview.Repo.get(id) do
      nil -> {:error, :not_found}
      board -> {:ok, board |> KanbanLiveview.Repo.preload(columns: :cards)}
    end
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end

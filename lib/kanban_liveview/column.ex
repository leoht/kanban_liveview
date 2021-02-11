defmodule KanbanLiveview.Column do
  use Ecto.Schema
  import Ecto.Changeset

  schema "columns" do
    field :title, :string
    belongs_to :board, KanbanLiveview.Board
    has_many :cards, KanbanLiveview.Card

    timestamps()
  end

  @doc false
  def changeset(column, attrs) do
    column
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end

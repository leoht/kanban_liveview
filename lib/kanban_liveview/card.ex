defmodule KanbanLiveview.Card do
  use Ecto.Schema
  import Ecto.Changeset
  alias KanbanLiveview.{Repo, Card}

  schema "cards" do
    field :content, :string
    belongs_to :column, KanbanLiveview.Column

    timestamps()
  end

  def update(id, changes) do
    with card when not is_nil(card) <- Repo.get(Card, id),
         {:ok, card} <- do_update(card, changes) do
      {:ok, card |> Repo.preload(column: :board)}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp do_update(card, changes) do
    card
    |> changeset(changes)
    |> Repo.update()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:content, :column_id])
    |> validate_required([:content])
  end
end

defmodule KanbanLiveviewWeb.PageLiveTest do
  use KanbanLiveviewWeb.ConnCase

  import Phoenix.LiveViewTest

  test "connected render displays board title and column", %{conn: conn} do
    %{id: id} = create_board()
    %{id: _column_id} = create_column(id)

    {:ok, page_live, _disconnected_html} = live(conn, "/boards/#{id}")
    assert render(page_live) =~ "<h1>A test project</h1>"
    assert render(page_live) =~ "<h3 class=\"panel-title\">A test column</h3>"
  end

  test "wrong board URL redirects to error", %{conn: conn} do
    assert {:error, {:redirect, %{to: "/error"}}} = live(conn, "/boards/123")
  end

  test "adds new card", %{conn: conn} do
    %{id: board_id} = create_board()
    %{id: column_id} = create_column(board_id)

    {:ok, page_live, _disconnected_html} = live(conn, "/boards/#{board_id}")

    assert page_live
      |> element("button[phx-value-column=#{column_id}]")
      |> render_click() =~ "Something new"

    assert [%{content: "Something new"}] = KanbanLiveview.Repo.all(KanbanLiveview.Card)
  end

  test "updating a card's content", %{conn: conn} do
    %{id: board_id} = create_board()
    %{id: column_id} = create_column(board_id)
    %{id: card_id} =
      %KanbanLiveview.Card{content: "A test card", column_id: column_id}
      |> KanbanLiveview.Repo.insert!()
    {:ok, page_live, _disconnected_html} = live(conn, "/boards/#{board_id}")

    assert page_live
      |> element("textarea[phx-value-card=#{card_id}]")
      |> render_blur(%{value: "An updated card"}) =~ "An updated card"

    assert [%{content: "An updated card"}] = KanbanLiveview.Repo.all(KanbanLiveview.Card)
  end

  defp create_board() do
    %KanbanLiveview.Board{title: "A test project"}
    |> KanbanLiveview.Repo.insert!()
  end

  defp create_column(board_id) do
    %KanbanLiveview.Column{title: "A test column", board_id: board_id}
    |> KanbanLiveview.Repo.insert!()
  end
end

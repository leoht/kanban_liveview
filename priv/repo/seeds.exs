board = KanbanLiveview.Repo.insert!(%KanbanLiveview.Board{title: "Awesome project"})


backlog = KanbanLiveview.Repo.insert!(%KanbanLiveview.Column{title: "Backlog", board_id: board.id})


_in_progress = KanbanLiveview.Repo.insert!(%KanbanLiveview.Column{title: "In progress", board_id: board.id})
_done = KanbanLiveview.Repo.insert!(%KanbanLiveview.Column{title: "Done", board_id: board.id})


_card = KanbanLiveview.Repo.insert!(%KanbanLiveview.Card{content: "Put some nice cat picture on the homepage", column_id: backlog.id})

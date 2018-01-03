defmodule DiaryWeb.TodoController do
  use DiaryWeb, :controller

  alias Diary.D
  alias Diary.D.Todo

  action_fallback DiaryWeb.FallbackController

  def index(conn, _params) do
    todos = D.list_todos()
    render(conn, "index.json", todos: todos)
  end

  def create(conn, %{"todo" => todo_params}) do
    with {:ok, %Todo{} = todo} <- D.create_todo(todo_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", todo_path(conn, :show, todo))
      |> render("show.json", todo: todo)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = D.get_todo!(id)
    render(conn, "show.json", todo: todo)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = D.get_todo!(id)

    with {:ok, %Todo{} = todo} <- D.update_todo(todo, todo_params) do
      render(conn, "show.json", todo: todo)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = D.get_todo!(id)
    with {:ok, %Todo{}} <- D.delete_todo(todo) do
      send_resp(conn, :no_content, "")
    end
  end
end

defmodule DiaryWeb.UserController do
  use DiaryWeb, :controller

  alias Diary.D
  alias Diary.D.User

  action_fallback DiaryWeb.FallbackController

  def index(conn, _params) do
    users = D.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- D.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = D.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = D.get_user!(id)

    with {:ok, %User{} = user} <- D.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = D.get_user!(id)
    with {:ok, %User{}} <- D.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end

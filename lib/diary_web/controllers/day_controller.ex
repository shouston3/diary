defmodule DiaryWeb.DayController do
  use DiaryWeb, :controller

  alias Diary.D
  alias Diary.D.Day

  action_fallback DiaryWeb.FallbackController

  def index(conn, _params) do
    days = D.list_days()
    render(conn, "index.json", days: days)
  end

  def create(conn, %{"day" => day_params}) do
    with {:ok, %Day{} = day} <- D.create_day(day_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", day_path(conn, :show, day))
      |> render("show.json", day: day)
    end
  end

  def show(conn, %{"id" => id}) do
    day = D.get_day!(id)
    render(conn, "show.json", day: day)
  end

  def update(conn, %{"id" => id, "day" => day_params}) do
    day = D.get_day!(id)

    with {:ok, %Day{} = day} <- D.update_day(day, day_params) do
      render(conn, "show.json", day: day)
    end
  end

  def delete(conn, %{"id" => id}) do
    day = D.get_day!(id)
    with {:ok, %Day{}} <- D.delete_day(day) do
      send_resp(conn, :no_content, "")
    end
  end
end

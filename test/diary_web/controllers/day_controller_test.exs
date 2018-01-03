defmodule DiaryWeb.DayControllerTest do
  use DiaryWeb.ConnCase

  alias Diary.D
  alias Diary.D.Day

  @create_attrs %{date: ~N[2010-04-17 14:00:00.000000], diary_entry: "some diary_entry"}
  @update_attrs %{date: ~N[2011-05-18 15:01:01.000000], diary_entry: "some updated diary_entry"}
  @invalid_attrs %{date: nil, diary_entry: nil}

  def fixture(:day) do
    {:ok, day} = D.create_day(@create_attrs)
    day
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all days", %{conn: conn} do
      conn = get conn, day_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create day" do
    test "renders day when data is valid", %{conn: conn} do
      conn = post conn, day_path(conn, :create), day: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, day_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "date" => "2010-04-17T14:00:00.000000",
        "diary_entry" => "some diary_entry"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, day_path(conn, :create), day: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update day" do
    setup [:create_day]

    test "renders day when data is valid", %{conn: conn, day: %Day{id: id} = day} do
      conn = put conn, day_path(conn, :update, day), day: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, day_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "date" => "2011-05-18T15:01:01.000000",
        "diary_entry" => "some updated diary_entry"}
    end

    test "renders errors when data is invalid", %{conn: conn, day: day} do
      conn = put conn, day_path(conn, :update, day), day: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete day" do
    setup [:create_day]

    test "deletes chosen day", %{conn: conn, day: day} do
      conn = delete conn, day_path(conn, :delete, day)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, day_path(conn, :show, day)
      end
    end
  end

  defp create_day(_) do
    day = fixture(:day)
    {:ok, day: day}
  end
end

defmodule Diary.D.Day do
  use Ecto.Schema
  import Ecto.Changeset
  alias Diary.D.{Day, Todo}


  schema "days" do
    field :date, :naive_datetime
    field :diary_entry, :string
    field :user_id, :id

    has_many :todos, Todo

    timestamps()
  end

  @doc false
  def changeset(%Day{} = day, attrs) do
    day
    |> cast(attrs, [:date, :diary_entry])
    |> validate_required([:date, :diary_entry])
  end
end

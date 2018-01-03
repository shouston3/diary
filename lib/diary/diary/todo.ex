defmodule Diary.Diary.Todo do
  use Ecto.Schema
  import Ecto.Changeset
  alias Diary.Diary.Todo


  schema "todos" do
    field :description, :string
    field :title, :string
    field :day_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Todo{} = todo, attrs) do
    todo
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end

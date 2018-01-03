defmodule Diary.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :title, :string
      add :description, :string
      add :day_id, references(:days, on_delete: :nothing)

      timestamps()
    end

    create index(:todos, [:day_id])
  end
end

defmodule Diary.Repo.Migrations.CreateDays do
  use Ecto.Migration

  def change do
    create table(:days) do
      add :date, :naive_datetime
      add :diary_entry, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:days, [:user_id])
  end
end

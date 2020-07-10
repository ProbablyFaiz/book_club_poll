defmodule BookClubPoll.Repo.Migrations.CreatePolls do
  use Ecto.Migration

  def change do
    create table(:polls) do
      add :name, :string
      add :description, :string
      add :end_date, :naive_datetime

      timestamps()
    end

  end
end

defmodule BookClubPoll.Repo.Migrations.AddBallotsTable do
  use Ecto.Migration

  def change do
    create table("ballots") do
      add :poll_id, references(:polls)
      add :name, :string, size: 40
      add :other_notes, :string

      timestamps()
    end
  end
end

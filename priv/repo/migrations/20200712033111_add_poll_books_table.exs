defmodule BookClubPoll.Repo.Migrations.AddPollBooksTable do
  use Ecto.Migration

  def change do
    create table("poll_book_options") do
      add :poll_id, references(:polls)
      add :name, :string
      add :url, :string

      timestamps()
    end
    alter table("polls") do
      add :num_ranks, :integer
    end
  end
end

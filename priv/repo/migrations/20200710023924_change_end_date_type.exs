defmodule BookClubPoll.Repo.Migrations.ChangeEndDateType do
  use Ecto.Migration

  def change do
    alter table("polls") do
      modify :end_date, :date
    end
  end
end

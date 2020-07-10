defmodule BookClubPoll.Repo do
  use Ecto.Repo,
    otp_app: :book_club_poll,
    adapter: Ecto.Adapters.Postgres
end

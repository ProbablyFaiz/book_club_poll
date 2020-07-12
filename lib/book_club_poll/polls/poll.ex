defmodule BookClubPoll.Polls.Poll do
  use Ecto.Schema
  import Ecto.Changeset

  alias BookClubPoll.PollBookOptions.PollBookOption

  schema "polls" do
    field :description, :string
    field :end_date, :date
    field :name, :string
    field :num_ranks, :integer
    has_many :poll_book_options, PollBookOption

    timestamps()
  end

  @doc false
  def changeset(poll, attrs) do
    poll
    |> cast(attrs, [:name, :description, :num_ranks, :end_date])
    |> validate_required([:name])
  end
end

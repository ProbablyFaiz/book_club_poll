defmodule BookClubPoll.PollBookOption.PollBookOption do
  use Ecto.Schema
  import Ecto.Changeset

  alias BookClubPoll.Polls.Poll

  schema "poll_book_options" do
    field :poll
    field :name, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(poll_book_option, attrs) do
    poll_book_option
    |> cast(attrs, [:name, :url])
    |> validate_required([:name, :url])
  end
end

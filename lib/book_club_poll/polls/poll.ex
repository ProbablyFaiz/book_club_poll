defmodule BookClubPoll.Polls.Poll do
  use Ecto.Schema
  import Ecto.Changeset

  schema "polls" do
    field :description, :string
    field :end_date, :date
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(poll, attrs) do
    poll
    |> cast(attrs, [:name, :description, :end_date])
    |> validate_required([:name])
  end
end

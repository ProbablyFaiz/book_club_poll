defmodule BookClubPoll.Ballots.Ballot do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ballots" do
    field :name, :string
    field :other_notes, :string

    timestamps()
  end

  @doc false
  def changeset(ballot, attrs) do
    ballot
    |> cast(attrs, [:name, :other_notes])
    |> validate_required([:name, :other_notes])
  end
end

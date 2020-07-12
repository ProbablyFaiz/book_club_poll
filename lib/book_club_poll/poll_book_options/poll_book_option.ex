defmodule BookClubPoll.PollBookOption.PollBookOption do
  use Ecto.Schema
  import Ecto.Changeset

  alias BookClubPoll.Polls.Poll

  schema "poll_book_options" do
    belongs_to :poll, Poll
    field :name, :string
    field :url, :string

    field :temp_id, :string, virtual: true
    field :delete, :boolean, virtual: true

    timestamps()
  end

  @doc false
  def changeset(poll_book_option, attrs) do
    poll_book_option
    |> Map.put(:temp_id, (poll_book_option.temp_id || attrs["temp_id"]))
    |> cast(attrs, [:name, :url, :delete])
    |> validate_required([:name, :url])
    |> maybe_mark_for_deletion()
  end

  defp maybe_mark_for_deletion(%{data: %{id: nil}} = changeset), do: changeset
  defp maybe_mark_for_deletion(changeset) do
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end

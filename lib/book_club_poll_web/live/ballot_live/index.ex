defmodule BookClubPollWeb.BallotLive.Index do
  use BookClubPollWeb, :live_view

  alias BookClubPoll.Ballots
  alias BookClubPoll.Ballots.Ballot

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :ballots, list_ballots())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Ballot")
    |> assign(:ballot, Ballots.get_ballot!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Ballot")
    |> assign(:ballot, %Ballot{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Ballots")
    |> assign(:ballot, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    ballot = Ballots.get_ballot!(id)
    {:ok, _} = Ballots.delete_ballot(ballot)

    {:noreply, assign(socket, :ballots, list_ballots())}
  end

  defp list_ballots do
    Ballots.list_ballots()
  end
end

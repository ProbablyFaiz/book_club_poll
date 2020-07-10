defmodule BookClubPollWeb.BallotLive.Show do
  use BookClubPollWeb, :live_view

  alias BookClubPoll.Ballots

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:ballot, Ballots.get_ballot!(id))}
  end

  defp page_title(:show), do: "Show Ballot"
  defp page_title(:edit), do: "Edit Ballot"
end

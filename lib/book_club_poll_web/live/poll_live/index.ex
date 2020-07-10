defmodule BookClubPollWeb.PollLive.Index do
  use BookClubPollWeb, :live_view

  alias BookClubPoll.Polls
  alias BookClubPoll.Polls.Poll

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :polls, list_polls())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Poll")
    |> assign(:poll, Polls.get_poll!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Poll")
    |> assign(:poll, %Poll{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Polls")
    |> assign(:poll, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    poll = Polls.get_poll!(id)
    {:ok, _} = Polls.delete_poll(poll)

    {:noreply, assign(socket, :polls, list_polls())}
  end

  defp list_polls do
    Polls.list_polls()
  end
end

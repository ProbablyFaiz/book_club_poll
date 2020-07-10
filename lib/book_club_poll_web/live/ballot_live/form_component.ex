defmodule BookClubPollWeb.BallotLive.FormComponent do
  use BookClubPollWeb, :live_component

  alias BookClubPoll.Ballots

  @impl true
  def update(%{ballot: ballot} = assigns, socket) do
    changeset = Ballots.change_ballot(ballot)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"ballot" => ballot_params}, socket) do
    changeset =
      socket.assigns.ballot
      |> Ballots.change_ballot(ballot_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"ballot" => ballot_params}, socket) do
    save_ballot(socket, socket.assigns.action, ballot_params)
  end

  defp save_ballot(socket, :edit, ballot_params) do
    case Ballots.update_ballot(socket.assigns.ballot, ballot_params) do
      {:ok, _ballot} ->
        {:noreply,
         socket
         |> put_flash(:info, "Ballot updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_ballot(socket, :new, ballot_params) do
    case Ballots.create_ballot(ballot_params) do
      {:ok, _ballot} ->
        {:noreply,
         socket
         |> put_flash(:info, "Ballot created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

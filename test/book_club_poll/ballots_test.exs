defmodule BookClubPoll.BallotsTest do
  use BookClubPoll.DataCase

  alias BookClubPoll.Ballots

  describe "ballots" do
    alias BookClubPoll.Ballots.Ballot

    @valid_attrs %{name: "some name", other_notes: "some other_notes"}
    @update_attrs %{name: "some updated name", other_notes: "some updated other_notes"}
    @invalid_attrs %{name: nil, other_notes: nil}

    def ballot_fixture(attrs \\ %{}) do
      {:ok, ballot} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ballots.create_ballot()

      ballot
    end

    test "list_ballots/0 returns all ballots" do
      ballot = ballot_fixture()
      assert Ballots.list_ballots() == [ballot]
    end

    test "get_ballot!/1 returns the ballot with given id" do
      ballot = ballot_fixture()
      assert Ballots.get_ballot!(ballot.id) == ballot
    end

    test "create_ballot/1 with valid data creates a ballot" do
      assert {:ok, %Ballot{} = ballot} = Ballots.create_ballot(@valid_attrs)
      assert ballot.name == "some name"
      assert ballot.other_notes == "some other_notes"
    end

    test "create_ballot/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ballots.create_ballot(@invalid_attrs)
    end

    test "update_ballot/2 with valid data updates the ballot" do
      ballot = ballot_fixture()
      assert {:ok, %Ballot{} = ballot} = Ballots.update_ballot(ballot, @update_attrs)
      assert ballot.name == "some updated name"
      assert ballot.other_notes == "some updated other_notes"
    end

    test "update_ballot/2 with invalid data returns error changeset" do
      ballot = ballot_fixture()
      assert {:error, %Ecto.Changeset{}} = Ballots.update_ballot(ballot, @invalid_attrs)
      assert ballot == Ballots.get_ballot!(ballot.id)
    end

    test "delete_ballot/1 deletes the ballot" do
      ballot = ballot_fixture()
      assert {:ok, %Ballot{}} = Ballots.delete_ballot(ballot)
      assert_raise Ecto.NoResultsError, fn -> Ballots.get_ballot!(ballot.id) end
    end

    test "change_ballot/1 returns a ballot changeset" do
      ballot = ballot_fixture()
      assert %Ecto.Changeset{} = Ballots.change_ballot(ballot)
    end
  end
end

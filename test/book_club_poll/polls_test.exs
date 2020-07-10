defmodule BookClubPoll.PollsTest do
  use BookClubPoll.DataCase

  alias BookClubPoll.Polls

  describe "polls" do
    alias BookClubPoll.Polls.Poll

    @valid_attrs %{description: "some description", end_date: ~N[2010-04-17 14:00:00], name: "some name"}
    @update_attrs %{description: "some updated description", end_date: ~N[2011-05-18 15:01:01], name: "some updated name"}
    @invalid_attrs %{description: nil, end_date: nil, name: nil}

    def poll_fixture(attrs \\ %{}) do
      {:ok, poll} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Polls.create_poll()

      poll
    end

    test "list_polls/0 returns all polls" do
      poll = poll_fixture()
      assert Polls.list_polls() == [poll]
    end

    test "get_poll!/1 returns the poll with given id" do
      poll = poll_fixture()
      assert Polls.get_poll!(poll.id) == poll
    end

    test "create_poll/1 with valid data creates a poll" do
      assert {:ok, %Poll{} = poll} = Polls.create_poll(@valid_attrs)
      assert poll.description == "some description"
      assert poll.end_date == ~N[2010-04-17 14:00:00]
      assert poll.name == "some name"
    end

    test "create_poll/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Polls.create_poll(@invalid_attrs)
    end

    test "update_poll/2 with valid data updates the poll" do
      poll = poll_fixture()
      assert {:ok, %Poll{} = poll} = Polls.update_poll(poll, @update_attrs)
      assert poll.description == "some updated description"
      assert poll.end_date == ~N[2011-05-18 15:01:01]
      assert poll.name == "some updated name"
    end

    test "update_poll/2 with invalid data returns error changeset" do
      poll = poll_fixture()
      assert {:error, %Ecto.Changeset{}} = Polls.update_poll(poll, @invalid_attrs)
      assert poll == Polls.get_poll!(poll.id)
    end

    test "delete_poll/1 deletes the poll" do
      poll = poll_fixture()
      assert {:ok, %Poll{}} = Polls.delete_poll(poll)
      assert_raise Ecto.NoResultsError, fn -> Polls.get_poll!(poll.id) end
    end

    test "change_poll/1 returns a poll changeset" do
      poll = poll_fixture()
      assert %Ecto.Changeset{} = Polls.change_poll(poll)
    end
  end
end

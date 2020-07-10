defmodule BookClubPollWeb.PollLiveTest do
  use BookClubPollWeb.ConnCase

  import Phoenix.LiveViewTest

  alias BookClubPoll.Polls

  @create_attrs %{description: "some description", end_date: ~N[2010-04-17 14:00:00], name: "some name"}
  @update_attrs %{description: "some updated description", end_date: ~N[2011-05-18 15:01:01], name: "some updated name"}
  @invalid_attrs %{description: nil, end_date: nil, name: nil}

  defp fixture(:poll) do
    {:ok, poll} = Polls.create_poll(@create_attrs)
    poll
  end

  defp create_poll(_) do
    poll = fixture(:poll)
    %{poll: poll}
  end

  describe "Index" do
    setup [:create_poll]

    test "lists all polls", %{conn: conn, poll: poll} do
      {:ok, _index_live, html} = live(conn, Routes.poll_index_path(conn, :index))

      assert html =~ "Listing Polls"
      assert html =~ poll.description
    end

    test "saves new poll", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.poll_index_path(conn, :index))

      assert index_live |> element("a", "New Poll") |> render_click() =~
               "New Poll"

      assert_patch(index_live, Routes.poll_index_path(conn, :new))

      assert index_live
             |> form("#poll-form", poll: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#poll-form", poll: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.poll_index_path(conn, :index))

      assert html =~ "Poll created successfully"
      assert html =~ "some description"
    end

    test "updates poll in listing", %{conn: conn, poll: poll} do
      {:ok, index_live, _html} = live(conn, Routes.poll_index_path(conn, :index))

      assert index_live |> element("#poll-#{poll.id} a", "Edit") |> render_click() =~
               "Edit Poll"

      assert_patch(index_live, Routes.poll_index_path(conn, :edit, poll))

      assert index_live
             |> form("#poll-form", poll: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#poll-form", poll: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.poll_index_path(conn, :index))

      assert html =~ "Poll updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes poll in listing", %{conn: conn, poll: poll} do
      {:ok, index_live, _html} = live(conn, Routes.poll_index_path(conn, :index))

      assert index_live |> element("#poll-#{poll.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#poll-#{poll.id}")
    end
  end

  describe "Show" do
    setup [:create_poll]

    test "displays poll", %{conn: conn, poll: poll} do
      {:ok, _show_live, html} = live(conn, Routes.poll_show_path(conn, :show, poll))

      assert html =~ "Show Poll"
      assert html =~ poll.description
    end

    test "updates poll within modal", %{conn: conn, poll: poll} do
      {:ok, show_live, _html} = live(conn, Routes.poll_show_path(conn, :show, poll))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Poll"

      assert_patch(show_live, Routes.poll_show_path(conn, :edit, poll))

      assert show_live
             |> form("#poll-form", poll: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#poll-form", poll: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.poll_show_path(conn, :show, poll))

      assert html =~ "Poll updated successfully"
      assert html =~ "some updated description"
    end
  end
end

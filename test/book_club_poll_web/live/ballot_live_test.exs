defmodule BookClubPollWeb.BallotLiveTest do
  use BookClubPollWeb.ConnCase

  import Phoenix.LiveViewTest

  alias BookClubPoll.Ballots

  @create_attrs %{name: "some name", other_notes: "some other_notes"}
  @update_attrs %{name: "some updated name", other_notes: "some updated other_notes"}
  @invalid_attrs %{name: nil, other_notes: nil}

  defp fixture(:ballot) do
    {:ok, ballot} = Ballots.create_ballot(@create_attrs)
    ballot
  end

  defp create_ballot(_) do
    ballot = fixture(:ballot)
    %{ballot: ballot}
  end

  describe "Index" do
    setup [:create_ballot]

    test "lists all ballots", %{conn: conn, ballot: ballot} do
      {:ok, _index_live, html} = live(conn, Routes.ballot_index_path(conn, :index))

      assert html =~ "Listing Ballots"
      assert html =~ ballot.name
    end

    test "saves new ballot", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.ballot_index_path(conn, :index))

      assert index_live |> element("a", "New Ballot") |> render_click() =~
               "New Ballot"

      assert_patch(index_live, Routes.ballot_index_path(conn, :new))

      assert index_live
             |> form("#ballot-form", ballot: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#ballot-form", ballot: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ballot_index_path(conn, :index))

      assert html =~ "Ballot created successfully"
      assert html =~ "some name"
    end

    test "updates ballot in listing", %{conn: conn, ballot: ballot} do
      {:ok, index_live, _html} = live(conn, Routes.ballot_index_path(conn, :index))

      assert index_live |> element("#ballot-#{ballot.id} a", "Edit") |> render_click() =~
               "Edit Ballot"

      assert_patch(index_live, Routes.ballot_index_path(conn, :edit, ballot))

      assert index_live
             |> form("#ballot-form", ballot: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#ballot-form", ballot: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ballot_index_path(conn, :index))

      assert html =~ "Ballot updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes ballot in listing", %{conn: conn, ballot: ballot} do
      {:ok, index_live, _html} = live(conn, Routes.ballot_index_path(conn, :index))

      assert index_live |> element("#ballot-#{ballot.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#ballot-#{ballot.id}")
    end
  end

  describe "Show" do
    setup [:create_ballot]

    test "displays ballot", %{conn: conn, ballot: ballot} do
      {:ok, _show_live, html} = live(conn, Routes.ballot_show_path(conn, :show, ballot))

      assert html =~ "Show Ballot"
      assert html =~ ballot.name
    end

    test "updates ballot within modal", %{conn: conn, ballot: ballot} do
      {:ok, show_live, _html} = live(conn, Routes.ballot_show_path(conn, :show, ballot))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Ballot"

      assert_patch(show_live, Routes.ballot_show_path(conn, :edit, ballot))

      assert show_live
             |> form("#ballot-form", ballot: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#ballot-form", ballot: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ballot_show_path(conn, :show, ballot))

      assert html =~ "Ballot updated successfully"
      assert html =~ "some updated name"
    end
  end
end

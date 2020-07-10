defmodule BookClubPollWeb.Router do
  use BookClubPollWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BookClubPollWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BookClubPollWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/polls", PollLive.Index, :index
    live "/polls/new", PollLive.Index, :new
    live "/polls/:id/edit", PollLive.Index, :edit
    live "/polls/:id", PollLive.Show, :show
    live "/polls/:id/show/edit", PollLive.Show, :edit

    live "/ballots", BallotLive.Index, :index
    live "/ballots/new", BallotLive.Index, :new
    live "/ballots/:id/edit", BallotLive.Index, :edit
    live "/ballots/:id", BallotLive.Show, :show
    live "/ballots/:id/show/edit", BallotLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", BookClubPollWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BookClubPollWeb.Telemetry
    end
  end
end

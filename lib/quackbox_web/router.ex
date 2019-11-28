defmodule QuackboxWeb.Router do
  use QuackboxWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", QuackboxWeb do
    pipe_through :browser

    resources "/rooms", RoomController, only: [:create, :show] do
      get "/host", HostController, :index
    end
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", QuackboxWeb do
  #   pipe_through :api
  # end
end

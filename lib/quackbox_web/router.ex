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

  pipeline :admin do
    plug QuackboxWeb.EnsureRolePlug, :admin
  end

  scope "/admin", QuackboxWeb.Admin, as: :admin do
    pipe_through [:browser, :admin]
    
    resources "/categories", CategoryController
    resources "/questions", QuestionController
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", QuackboxWeb do
    pipe_through :browser

    resources "/rooms", RoomController, only: [:create], param: "access_code" do
      get "/host", HostController, :index
      get "/play", PlayerController, :show, as: :play
      get "/watch", AudienceMemberController, :show, as: :watch
    end

    post "/join", PlayerController, :create, as: :join

    get "/", PageController, :index
  end
  # Other scopes may use custom stacks.
  # scope "/api", QuackboxWeb do
  #   pipe_through :api
  # end
end

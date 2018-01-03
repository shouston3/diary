defmodule DiaryWeb.Router do
  use DiaryWeb, :router

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

  scope "/", DiaryWeb do
    pipe_through :browser # Use the default browser stack

    get "/", HomeController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", DiaryWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/days", DayController, except: [:new, :edit]
    resources "/todos", TodoController, except: [:new, :edit]
  end
end

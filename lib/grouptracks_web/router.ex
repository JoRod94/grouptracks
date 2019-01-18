defmodule GrouptracksWeb.Router do
  use GrouptracksWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: GrouptracksWeb.Schema,
      interface: :simple,
      context: %{pubsub: GrouptracksWeb.Endpoint}
  end
end

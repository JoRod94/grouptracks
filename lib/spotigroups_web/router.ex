defmodule SpotigroupsWeb.Router do
  use SpotigroupsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: SpotigroupsWeb.Schema,
      interface: :simple,
      context: %{pubsub: SpotigroupsWeb.Endpoint}
  end
end

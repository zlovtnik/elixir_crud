defmodule ErpWeb.Router do
  use ErpWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/" do
    pipe_through(:api)

    forward("/api", Absinthe.Plug, schema: ErpWeb.Schema)

    forward("/graphiql", Absinthe.Plug.GraphiQL,
      schema: ErpWeb.Schema,
      interface: :playground
    )
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:erp, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through([:fetch_session, :protect_from_forgery])
      live_dashboard("/dashboard", metrics: ErpWeb.Telemetry)
    end
  end
end

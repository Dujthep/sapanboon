defmodule SapanboonWeb.TodoLive do
    use Phoenix.LiveView
    # import Calendar.Strftime
    # alias SapanboonWeb.ProjectsView
    require Logger

    def render(assigns) do
        ~L"""
        Current temperature: <%= @temperature %>
        <button phx-click="inc_temperature">+</button>
        """
    end

    def mount(_params,project  , socket) do
        IO.inspect(project)
        {:ok, assign(socket, :temperature, 38)}
    end

  end

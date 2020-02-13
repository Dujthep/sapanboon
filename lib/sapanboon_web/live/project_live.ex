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

    def mount(_params, socket) do
        {:ok, assign(socket, :temperature, 38)}
    end

    def handle_event("inc_temperature", _value, socket) do
        {:ok, new_temp} = Thermostat.inc_temperature(socket.assigns.id)
        {:noreply, assign(socket, :temperature, new_temp)}
    end
  end

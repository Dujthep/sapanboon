defmodule SapanboonWeb.TodoLive do
    use Phoenix.LiveView
    import Calendar.Strftime
    alias SapanboonWeb.ProjectsView

    def render(assigns), do: ProjectsView.render("todo.html", assigns)
  
    def mount(_session, socket) do
        if connected?(socket), do: Process.send_after(self(), :tick, 1000)
        {:ok, assign(socket, val: 72, mode: :cooling, time: :calendar.local_time())}
    end

    def handle_info(:tick, socket) do
        Process.send_after(self(), :tick, 1000)
        {:noreply, assign(socket, time: :calendar.local_time())}
    end

    # def handle_event("inc", _, socket) do
    # IO.inspect("inc")
    # {:noreply, update(socket, :val, &(&1 + 1))}
    # end

    # def handle_event("dec", _, socket) do
    #     IO.inspect("dec")
    #     {:noreply, update(socket, :val, &(&1 - 1))}
    # end

    # def handle_event("toggle-mode", _, socket) do
    #     {:noreply,
    #     update(socket, :mode, fn
    #     :cooling -> :heating
    #     :heating -> :cooling
    #     end)}
    # end
  end
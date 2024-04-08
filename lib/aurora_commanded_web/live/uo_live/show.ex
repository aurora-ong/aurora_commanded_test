defmodule AuroraCommandedWeb.UOLive.Show do
  use AuroraCommandedWeb, :live_view

  alias AuroraCommanded.Aurora

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:uo, Aurora.get_uo!(id))}
  end

  defp page_title(:show), do: "Show Uo"
  defp page_title(:edit), do: "Edit Uo"
end

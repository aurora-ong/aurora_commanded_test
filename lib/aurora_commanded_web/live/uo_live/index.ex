defmodule AuroraCommandedWeb.UOLive.Index do
  use AuroraCommandedWeb, :live_view

    alias AuroraCommanded.Aurora.UO

  @impl true
  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(AuroraCommanded.PubSub, "projector_update")

    socket =
      socket
      |> stream_configure(:uo_table, dom_id: &"ou-#{&1.uo_id}")
      |> stream(:uo_table, AuroraCommanded.Aurora.list_uo_table())
      |> assign(:page_title, "UO List")
      |> assign(:page_title, "UO List")
      |> assign(:uo, nil)

    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  @impl true
  @spec handle_info(:uo, Phoenix.LiveView.Socket.t()) :: {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_info(:uo, socket) do
    {:noreply, redirect(socket, external: "/")}
  end

  # def handle_info(%{topic: "public.events", payload: state}, socket) do
  #   IO.puts("HANDLE BROADCAST FOR #{state[:status]}")
  #   {:noreply, assign(socket, state)}
  # end

end

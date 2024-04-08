defmodule AuroraCommandedWeb.UOLive.FormComponent do
  use AuroraCommandedWeb, :live_component

  alias AuroraCommanded.Aurora

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage uo records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="uo-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:users]} type="text" label="Users" />
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:age]} type="number" label="Age" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Uo</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{uo: uo} = assigns, socket) do
    changeset = Aurora.change_uo(uo)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"uo" => uo_params}, socket) do
    changeset =
      socket.assigns.uo
      |> Aurora.change_uo(uo_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"uo" => uo_params}, socket) do
    save_uo(socket, socket.assigns.action, uo_params)
  end

  defp save_uo(socket, :edit, uo_params) do
    case Aurora.update_uo(socket.assigns.uo, uo_params) do
      {:ok, uo} ->
        notify_parent({:saved, uo})

        {:noreply,
         socket
         |> put_flash(:info, "Uo updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_uo(socket, :new, uo_params) do
    case Aurora.create_uo(uo_params) do
      {:ok, uo} ->
        notify_parent({:saved, uo})

        {:noreply,
         socket
         |> put_flash(:info, "Uo created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

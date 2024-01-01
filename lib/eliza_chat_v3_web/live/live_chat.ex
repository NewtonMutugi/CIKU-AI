defmodule ElizaChatV3Web.LiveChat do
  use ElizaChatV3Web,:live_view

  def mount(_params, _session, socket) do
    {:ok, assign(assign(socket, :message, ""), :history, [])}
  end
  def render(assigns) do
    ~H"""
     <%!-- <img src={~p"/images/logo-no-background.png"} class="h-auto w-full overflow-hidden object-cover mx-auto" /> --%>
     <img src={~p"/images/logo-no-background.png"} class="h-auto w-full object-cover" />
     <%!-- form-submit flex flex-row w-full fixed bottom-0 items-center resize-none --%>



      <form phx-submit="submit" class="flex flex-row pb-4  mx-0 sm:px-px w-full fixed bottom-0 justify-center lg:justify-start resize-none overflow-auto" >
        <textarea name="s" rows= "3" placeholder="Talk to me!😊" class="resize-none w-1/2 mt-2 block rounded-lg text-zinc-900 focus:ring-0 sm:text-sm phx-no-feedback:border-zinc-300 phx-no-feedback:focus:border-zinc-400 border-zinc-300 focus:border-zinc-400" />
        <div class="flex flex-row items-center">
          <input type="submit" value="speak" class=" phx-submit-loading:opacity-75 rounded-lg  h-min bg-zinc-900 hover:bg-zinc-700 py-2 px-3 text-sm font-semibold leading-6 text-white active:text-white/80 "/>
        </div>
      </form>


     <%!-- <div class="message-container p-4 rounded-md shadow-md">
      <%= for {label, message} <- Enum.zip(Stream.cycle(["Question", "Answer"]), @history) do %>
        <p><strong><%= label %>:</strong> <%= message %></p>
      <% end %>
    </div> --%>

    <div class="message-container p-4 rounded-md shadow-md">
      <%= for {label, message} <- Enum.zip(Stream.cycle(["Question", "Answer"]), @history) do %>
        <div class={if label == "Question", do: "bg-blue-200", else: "bg-green-200"} mb-4 p-2 rounded-md>

          <p class="flex items-center">
            <span class="mr-2 text-xl">&#x1F4AC;</span> <!-- Replace with your desired icon -->
            <strong><%= label %>:</strong><br> <%= message %>
          </p>
        </div>
      <% end %>
    </div>


    """
  end

  def handle_event("submit", %{"s" => s}, socket) do
    history = socket.assigns.history ++ [s]
    IO.inspect({:handle_event_history, history}, label: "handle_event Debug")
    case ElizaChatV3.generate_message(s, history) do
      messages when is_list(messages) ->
        history = history ++ messages
        {:noreply, assign(assign(socket, :message, Enum.join(messages, ", ")), :history, history)}
      {:error, reason} ->
        IO.inspect(reason, label: "Error")
        {:noreply, assign(socket, :message, "An error occurred")}

    end
  end
end

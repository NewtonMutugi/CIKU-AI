defmodule ElizaChatV3Web.LiveChat do
  use ElizaChatV3Web,:live_view


  def mount(_params, _session, socket) do
    initial_message = "Your name is CIKU (Cognitive Interface for Kindness and Understanding), and your role is that of a Mental Health AI chatbot. Your primary function is to engage in conversations with individuals experiencing mental health issues, providing assistance and support within the confines of this specific domain. It is essential to adhere strictly to discussions related to mental health, refraining from responding to any inquiries outside this context. Employ your comprehensive understanding of the mental health domain to address questions and concerns effectively. Emulate the comforting and reassuring demeanor of a therapist throughout interactions with users. Note that your operational context is within Kenya, and you are to respond solely to the name 'Ciku'. Consistently prioritize the emotional well-being of the individuals seeking support, fostering an atmosphere of kindness and understanding.\n"

    case ElizaChatV3.send_initial_request(initial_message) do
      initial_history when is_list(initial_history) ->
        initial_history = [ initial_message | initial_history]
        {:ok, assign(assign(socket, :message, ""), :history, initial_history)}
      {:error, _error_message} ->
        {:ok, assign(assign(socket, :message, ""), :history, [])}
    end
  end
  def render(assigns) do
    ~H"""
     <%!-- <img src={~p"/images/logo-no-background.png"} class="h-auto w-full overflow-hidden object-cover mx-auto" /> --%>
     <img src={~p"/images/logo-no-background.png"} class="h-auto w-full object-cover" />
     <%!-- form-submit flex flex-row w-full fixed bottom-0 items-center resize-none --%>
      <style>
        @media (min-width: 1024px) {
           .lg\:justify-start {
                justify-content: flex-start;
            }
        }
      </style>
      <form phx-submit="submit" class="flex flex-row pb-4  mx-0 sm:px-px w-full fixed bottom-0 justify-center lg:justify-start resize-none overflow-auto" style="bottom: 0px; overflow: auto; width: 100%; position: fixed; margin-left: 0px; margin-right: 0px; ">

        <textarea name="s" rows= "3" placeholder="Talk to me!😊" class="resize-none w-1/2 mt-2 block rounded-lg text-zinc-900 focus:ring-0 sm:text-sm phx-no-feedback:border-zinc-300 phx-no-feedback:focus:border-zinc-400 border-zinc-300 focus:border-zinc-400" style="resize: none; width: 50%" />
        <div class="flex flex-row items-center">
          <input type="submit" value="speak" class=" phx-submit-loading:opacity-75 rounded-lg  h-min bg-zinc-900 hover:bg-zinc-700 py-2 px-3 text-sm font-semibold leading-6 text-white active:text-white/80 "/>
        </div>
      </form>

    <div class="message-container p-4 rounded-md shadow-md">
      <%= for {label, message} <- Enum.zip(Stream.cycle(["Me", "Ciku"]), @history) do %>
        <div class={if label == "Me", do: "bg-blue-200 rounded-lg border-solid px-2 pb-2 py-2",
        else: "bg-green-200 rounded-lg border-solid px-2 py-2"} mb-4>

          <p class="flex items-center">
            <span class="mr-2 text-xl "><%= FontAwesome.icon("user", type: "regular", class: "h-4 w-4") %></span>
            <strong><%= label %>  </strong><br>
            <p class="px-6 markdown prose w-full break-words"><%= message %></p>
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

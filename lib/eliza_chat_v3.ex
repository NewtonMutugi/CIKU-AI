defmodule ElizaChatV3 do
  @moduledoc """
  ElizaChatV3 keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def generate_message(message, history) do
    api_key = System.get_env("API_KEY")
    url = "https://generativelanguage.googleapis.com/v1beta3/models/chat-bison-001:generateMessage?key=#{api_key}"
    headers = [{"Content-Type", "application/json"}]
    payload = %{
      "prompt" => %{
        "context" => Enum.join(history, "\n"),
        "examples" => [],
        "messages" => [%{"content" => message}]
      },
      "temperature" => 0.25,
      "top_k" => 40,
      "top_p" => 0.95,
      "candidate_count" => 1
    }

    # Log inputs
    IO.inspect({:generate_message_input, message, history}, label: "generate_message Debug")
    IO.inspect({:api_request, url, payload}, label: "api_request Debug")
    case HTTPoison.post(url, Jason.encode!(payload), headers, recv_timeout: 20000) do
      {:ok, %HTTPoison.Response{body: body}} ->
        IO.inspect(body, label: "API Response Body")
        {:ok, decoded} = Jason.decode(body)

        if decoded["filters"] do
          IO.inspect(decoded["filters"], label: "API Response Filters")
          decoded["filters"] |> Enum.map(& &1["reason"])
        else if decoded["error"] do
          IO.inspect(decoded["error"], label: "API Response Error")
          {:error, decoded["error"]["message"]}
        else
          IO.inspect(decoded["candidates"], label: "API Response Candidates")
          decoded["candidates"] |> Enum.map(& &1["content"])
        end
      end
    end
  end
end

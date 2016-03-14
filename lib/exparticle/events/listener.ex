defmodule ExParticle.Events.Listener do
  use GenServer
  alias HTTPoison.Error
  alias HTTPoison.AsyncChunk
  alias HTTPoison.AsyncEnd
  alias ExParticle.Events.Handler
  alias ExParticle.Model.SseEvent

  @default_recv_timeout 10000

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    {:ok, _response} = listen(self)
    {:ok, %SseEvent{}}
  end

  def handle_info(%AsyncChunk{chunk: chunk}, current_event) do
    case SseEvent.parse(chunk) do
      {:name, event_name} ->
        new_event = %SseEvent{current_event | name: event_name}
        {:noreply, new_event}

      {:data, %{"coreid" => coreid, "data" => data, "published_at" => published_at, "ttl" => ttl}} ->
        current_event = %SseEvent{current_event | data: data}
        current_event = %SseEvent{current_event | ttl: ttl}
        current_event = %SseEvent{current_event | published_at: published_at}
        current_event = %SseEvent{current_event | coreid: coreid}
        Handler.process(current_event)
        {:noreply, %SseEvent{}}

      {:event, event} ->
        struct(ExParticle.Model.SseEvent, event)
        |> Handler.process
        {:noreply, %SseEvent{}}

      _other ->
        {:noreply, current_event}
    end
  end
  def handle_info(%AsyncEnd{}, current_event) do
    Handler.process(current_event)
    {:stop, :no_data, current_event}
  end
  def handle_info(%Error{reason: {:closed, :timeout}}, current_event) do
    {:stop, :timeout, current_event}
  end
  def handle_info(_msg, current_event) do
    {:noreply, current_event}
  end

  defp listen(receiver_pid) do
    recv_timeout = config |> Dict.get(:listener_timeout, @default_recv_timeout)
    base_url = config |> Dict.get(:base_url)
    opts = [stream_to: receiver_pid,
            recv_timeout: recv_timeout,
            hackney: [:insecure]]

    HTTPoison.get base_url <> "/devices/events", headers, opts
  end

  defp headers do
    access_token = config |> Dict.get(:access_token)
    %{"Authorization" => "Bearer #{access_token}"}
  end

  defp config do
    Application.get_env(:exparticle, :api)
  end
end

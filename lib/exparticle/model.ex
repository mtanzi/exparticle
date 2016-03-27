defmodule ExParticle.Model.Device do
  defstruct id: nil, name: nil, last_app: nil, last_ip_address: nil, last_heard: nil, product_id: nil, connected: nil, status: nil
end

defmodule ExParticle.Model.DeviceInfo do
  defstruct cc3000_patch_version: nil, connected: nil, functions: nil, id: nil, last_heard: nil, name: nil, product_id: nil, status: nil, variables: nil
end

defmodule ExParticle.Model.DeviceVariable do
  defstruct cmd: nil, name: nil, result: nil, coreInfo: nil
end

defmodule ExParticle.Model.DeviceFunctionResult do
  defstruct id: nil, last_app: nil, connected: nil, return_value: nil
end

defmodule ExParticle.Model.SseEvent do
  defstruct name: nil, data: nil, ttl: nil, published_at: nil, coreid: nil

  def parse("\n"), do: :heartbeat
  def parse(":ok\n\n"), do: :connection_success
  def parse(chunk) do
    case chunk |> String.strip |> String.split("\n") do
      ["event: " <> event_name] ->
        {:name, event_name}
      ["data: " <> all_data] ->
        {:data, Poison.decode!(all_data)}
      ["event: " <> event_name, "data: " <> all_data] ->
        event = Poison.decode!(all_data)
               |> Map.put(:event, event_name)
        {:event, event}
    end
  end
end

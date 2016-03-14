defmodule ExParticle.Events.Event do
  defstruct type: nil,
            core_id: nil,
            action: nil

  alias ExParticle.Model.SseEvent, as: S

  @event_types [:status, :flash, :action]
  @actions [:online, :offline, :next]

  def from_sse_event(%S{name: "spark/status", data: data}) do
    %__MODULE__{type: :status,
                core_id: Map.get(data, "coreid"),
                action: data |> Map.get("data") |> safe_atomize}
  end
  def from_sse_event(%S{name: "spark/flash/status", data: data}) do
    %__MODULE__{type: :flash,
                core_id: Map.get(data, "coreid"),
                action: data |> Map.get("data") |> safe_atomize}
  end
  def from_sse_event(%S{name: "spark/device/app-hash", data: data}) do
    %__MODULE__{type: :flash,
                core_id: Map.get(data, "coreid"),
                action: data |> Map.get("data") |> safe_atomize}
  end
  def from_sse_event(%S{name: "info-bot-action", data: data}) do
    %__MODULE__{type: :action,
                core_id: Map.get(data, "coreid"),
                action: data |> Map.get("data") |> safe_atomize}
  end

  defp safe_atomize(string) do
    string
    |> String.strip
    |> String.to_existing_atom
  end
end

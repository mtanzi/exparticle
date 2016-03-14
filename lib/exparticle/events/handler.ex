defmodule ExParticle.Events.Handler do
  use GenServer
  alias ExParticle.Events.Event, as: PE
  require Logger

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, []}
  end

  def process(event) do
    GenServer.cast({__MODULE__, node}, {:process, event})
  end

  def events(function) do
    GenServer.cast({__MODULE__, node}, {:events, function})
  end

  def handle_cast({:process, event}, state) when is_function(state) do
    state.(event)
    {:noreply, state}
  end

  def handle_cast({:process, event}, state) do
    {:noreply, state}
  end

  def handle_cast({:events, function}, _state) do
    {:noreply, function}
  end
end

defmodule Exparticle.API.Devices do
  @moduledoc """
  Provides access to the `/devices` area of the Particle API.
  """
  import Exparticle.API.Base
  import Exparticle.Parser

  @doc """
  Fetches all the devices for the logged user
  """
  def devices do
    get("/devices") |> Enum.map(&parse_device/1)
  end

  @doc """
  Fetch the information for the given device
  """
  def device_info(id) do
    get("/devices/#{id}") |> parse_device_info
  end
end

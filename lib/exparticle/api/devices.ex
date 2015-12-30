defmodule ExParticle.API.Devices do
  @moduledoc """
  Provides access to the `/devices` area of the Particle API.
  """
  import ExParticle.API.Base
  import ExParticle.Parser

  @doc """
  Fetches all the devices for the logged user
  """
  def devices do
    get("/devices") |> Enum.map(&parse_device/1)
  end

  @doc """
  Fetch the information for the given device
  """
  def device_info(device_id) do
    get("/devices/#{device_id}") |> parse_device_info
  end

  @doc """
  generate a claim for the device
  """
  def create_claims do
    post("/device_claims")
  end

  @doc """
  fetch the variable requested
  """
  def device_vars(device_id, var_name) do
    get("/devices/#{device_id}/#{var_name}") |> parse_device_variable
  end

  def claim_device(device_id) do
    encoded_text = URI.encode_www_form(device_id)
    body = "id=#{encoded_text}"

    post("/devices", body)
  end

  def request_transfer(device_id) do
    encoded_text = URI.encode_www_form(device_id)
    body = "id=#{encoded_text}&request_transfer=true"

    post("/devices", body)
  end

  @doc """
  call the functtion for th given device
  """
  def call_function(device_id, function, args) do
    encoded_text = URI.encode_www_form(args)
    body = "args=#{encoded_text}"

    post("/devices/#{device_id}/#{function}", body) |> parse_device_function_result
  end
end

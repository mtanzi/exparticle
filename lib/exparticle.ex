defmodule Exparticle do
  @moduledoc """
  Provides access to the Particle Cloud API.
  """

  @doc """
  List devices the currently authenticated user has access to.

  ## Example
    iex> Exparticle.devices
    [%Exparticle.Model.Device{connected: true, id: "device_id",
      last_app: nil, last_heard: "2015-12-28T22:58:35.066Z",
      last_ip_address: "192.168.11.10", name: "my_iot", product_id: 6,
      status: "normal"}]
  """
  defdelegate devices, to: Exparticle.API.Devices, as: :devices

  @doc """
  Get basic information about the given device, including the custom variables
  and functions it has exposed.

  Params:
  * device_id

  ## Example
    iex> Exparticle.device_info("decice_id")
    %Exparticle.Model.DeviceInfo{
     cc3000_patch_version: "wl0: Nov  7 2014 16:03:45 version 5.90.230.12 FWID 01-212234f8",
     connected: false, functions: nil, id: "decice_id", last_heard: nil,
     name: "my_iot", product_id: 6, status: "normal", variables: nil}
  """
  defdelegate device_info(device_id), to: Exparticle.API.Devices, as: :device_info

  @doc """
  Generate a device claim code that allows the device to be successfully
  claimed to a user's account during the SoftAP setup process.

  ## Example
    iex> Exparticle.create_claims
    %{claim_code: "i31YZ5bRq9Z9xxX+YgGO6rY+DDJn6CzFpNA02wiBF9SvIgYbW3QtIhgnYVAt0Ow",
      device_ids: ["device_id"]}
  """
  defdelegate create_claims, to: Exparticle.API.Devices, as: :create_claims

  @doc """
  Request the current value of a variable exposed by the device.

  Params:
  * device_id
  * var_name

  ## Example:
    iex> Exparticle.device_vars("device_id", "analogvalue")
    %{cmd: "VarReturn",
      coreInfo: %{connected: true, deviceID: "device_id",
        last_app: "", last_handshake_at: "2015-12-29T20:16:03.762Z",
        last_heard: "2015-12-29T20:16:33.010Z", product_id: 6}, name: "analogvalue",
      result: 0}
  """
  defdelegate device_vars(device_id, var_name), to: Exparticle.API.Devices, as: :device_vars

  @doc """
  Claim a new or unclaimed device to your account.

  Params:
  * device_id

  Example:
    iex(1)> Exparticle.claim_device("3e002a001547343433313338")
    %{connected: true, id: "3e002a001547343433313338", ok: true,
      user_id: "56630100e5a6cbe63b0000c6"}
  """
  defdelegate claim_device(device_id), to: Exparticle.API.Devices, as: :claim_device

  @doc """
  Request device transfer from another user.

  Params:
  * device_id

  ## Example:
    iex(1)> Exparticle.request_transfer("device_id")
    %{connected: true, id: "device_id", ok: true,
      user_id: "56630100e5a6cbe63b0000c6"}
  """
  defdelegate request_transfer(device_id), to: Exparticle.API.Devices, as: :request_transfer

  @doc """
  Call a function exposed by the device, with arguments passed in the request body.

  Params:
  * device_id
  * function_name
  * args
  * format

  ## Example:
    iex> Exparticle.call_function("device_id", "function_name", "args")
    %{connected: true, id: "device_id", last_app: "", return_value: 1}
  """
  defdelegate call_function(device_id, function, args), to: Exparticle.API.Devices, as: :call_function
end

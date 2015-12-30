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

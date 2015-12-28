defmodule Exparticle.Parser do
  def parse_device(object) do
    struct(Exparticle.Model.Device, object)
  end

  def parse_device_info(object) do
    struct(Exparticle.Model.DeviceInfo, object)
  end
end

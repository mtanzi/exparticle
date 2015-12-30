defmodule Exparticle.Parser do
  def parse_device(object) do
    struct(Exparticle.Model.Device, object)
  end

  def parse_device_info(object) do
    struct(Exparticle.Model.DeviceInfo, object)
  end

  def parse_device_variable(object) do
    struct(Exparticle.Model.DeviceVariable, object)
  end

  def parse_device_function_result(object) do
    struct(Exparticle.Model.DeviceVariable, object)
  end
end

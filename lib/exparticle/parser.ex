defmodule ExParticle.Parser do
  def parse_device(object) do
    struct(ExParticle.Model.Device, object)
  end

  def parse_device_info(object) do
    struct(ExParticle.Model.DeviceInfo, object)
  end

  def parse_device_variable(object) do
    struct(ExParticle.Model.DeviceVariable, object)
  end

  def parse_device_function_result(object) do
    struct(ExParticle.Model.DeviceFunctionResult, object)
  end
end

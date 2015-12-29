defmodule ExparticleTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes", "test/fixture/custom_cassettes")

    :ok
  end

  test "get all the user's devices" do
    use_cassette "devices", custom: true do
      device = %Exparticle.Model.Device{
        connected: true,
        id: "device_id",
        last_heard: "2015-12-29T23:37:54.594Z",
        last_ip_address: "192.168.112.10",
        name: "device_name",
        product_id: 6,
        status: "normal"
      }

      assert device == Exparticle.devices |> List.first
    end
  end

  test "get the divice with the given id" do
    use_cassette "device_info", custom: true do
      device_info = %Exparticle.Model.DeviceInfo{
        connected: true,
        id: "device_id"
      }
      assert device_info == Exparticle.device_info("device_id")
    end
  end
end

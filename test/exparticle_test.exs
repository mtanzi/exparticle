defmodule ExParticleTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes", "test/fixture/custom_cassettes")
    ExVCR.Config.filter_url_params(true)
    ExVCR.Config.filter_sensitive_data("Authorization\": \"Bearer .+?\"", "Authorization\": \"Bearer <REMOVED>\"")
    # ExVCR.Config.filter_sensitive_data("\"id\": \".+?\"", "id\": \"device_id\"")
    :ok
  end

  test "get all the user's devices" do
    use_cassette "devices", custom: true do
      device = %ExParticle.Model.Device{
        connected: false,
        id: "device_id",
        last_heard: "2015-12-29T23:37:54.594Z",
        last_ip_address: "192.168.112.10",
        name: "device_name",
        product_id: 6,
        status: "normal"
      }

      assert device == ExParticle.devices |> List.first
    end
  end

  test "get the divice with the given id" do
    use_cassette "device_info", custom: true do
      device_info = %ExParticle.Model.DeviceInfo{
        connected: true,
        functions: ["led"],
        id: "device_info",
        last_heard: "2015-12-30T09:05:18.760Z",
        name: "my_device",
        product_id: 6,
        status: "normal",
        variables: %{analogvalue: "int32"}
      }
      assert device_info == ExParticle.device_info("device_id")
    end
  end

  test "create new claim" do
    use_cassette "create_claims", custom: true do
      new_claim = %{
        claim_code: "2P/aMS23P0We4lWxgOMB4k56x3tBrL8penXsezu8qFmaegQ0E4qtB7J8NkRYrZy",
        device_ids: ["device_id"]
      }

      assert new_claim == ExParticle.create_claims
    end
  end

  test "device variables" do
    use_cassette "device_vars", custom: true do
      device_var = %ExParticle.Model.DeviceVariable{
        cmd: "VarReturn",
        name: "analogvalue",
        result: 0,
      }

      assert device_var == ExParticle.device_vars("device_id", "analogvalue")
    end
  end

  test "a claim for device" do
    use_cassette "claim_device", custom: true do
      res = %{
        connected: true,
        id: "device_id",
        ok: true,
        user_id: "user_id"
      }

      assert res == ExParticle.claim_device("device_id")
    end
  end

  test "a request transfer" do
    use_cassette "request_transfer", custom: true do
      res = %{
        connected: true,
        id: "device_id",
        ok: true,
        user_id: "user_id"
      }

      assert res == ExParticle.request_transfer("device_id")
    end
  end

  test "a function call" do
    use_cassette "call_function", custom: true do
      res = %ExParticle.Model.DeviceFunctionResult{
        id: "device_id",
        last_app: "",
        connected: true,
        return_value: 1
      }
      ExParticle.call_function("device_id", "led", "on")
    end
  end

  

end

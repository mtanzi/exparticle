defmodule Exparticle.API.Base do
  require Logger

  @moduledoc """
  Provides general request making and handling functionality (for internal use).
  """
  alias Exparticle.Config

  @base_url "https://api.particle.io/v1"

  @doc """
  General HTTP `GET` request function. Takes a url part
  and optionally a token and list of params.
  """
  def get(url_part, params \\ []) do
    [url_part, params]
      |> build_url
      |> HTTPoison.get!(header)
      |> handle_response
  end

  @doc """
  General HTTP `POST` request function. Takes a url part,
  and optionally a token, data Map and list of params.
  """
  def post(url_part, data \\ "", params \\ []) do
    # encoded_text = URI.encode_www_form(data)
    # body = "args=#{encoded_text}"

    [url_part, params]
      |> build_url
      |> HTTPoison.post!(data, header_post)
      |> handle_response
  end

  @doc """
  General HTTP `DELETE` request function. Takes a url part
  and optionally a token and list of params.
  """
  def delete(url_part, params \\ []) do
    [url_part, params]
      |> build_url
      |> HTTPoison.delete!(header)
      |> handle_response
  end

  defp header do
    %{
      "Authorization" => "Bearer #{access_token}",
      "Accept" => "application/json"
    }
  end

  defp access_token do
    config = Application.get_env(:exparticle, :api)
    Dict.get(config, :access_token)
  end

  defp header_post do
    %{"Content-Type" => "application/x-www-form-urlencoded"}
    |> Map.merge(header)
  end

  defp handle_response(%HTTPoison.Response{body: body, status_code: status_code}) do
    response = Poison.decode!(body, keys: :atoms)
    case status_code do
      200 -> response
      _ -> raise(Exparticle.Error, [code: response.meta.code, message: "#{response.meta.error_type}: #{response.meta.error_message}"])
    end
  end

  defp build_url([part, []]) do
   "#{@base_url}#{part}"
  end
  defp build_url([part, params]) do
    "#{@base_url}#{part}?#{params_join(params)}"
  end

  defp params_join(params) do
    params_join(params, "")
  end
  defp params_join([h | []], string) do
    [param, value] = h
    string <> "&#{param}=#{value}"
  end
  defp params_join([h | t], "") do
    [param | value] = h
    params_join(t, "#{param}=#{value}")
  end
  defp params_join([h | t], string) do
    [param | value] = h
    params_join(t, string<>"&#{param}=#{value}")
  end
end

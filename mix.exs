defmodule ExParticle.Mixfile do
  use Mix.Project

  def project do
    [
      app: :exparticle,
      version: "0.0.1",
      elixir: "~> 1.0",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description,
      package: package,
      deps: deps,
      docs: [extras: ["README.md"], main: "extra-readme"]
    ]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp description do
    """
    ExParticle is an client to use Particle Cloud API
    """
  end

  defp package do
    [licenses: ["MIT"],
     maintainers: ["Marco Tanzi"],
     links: %{"Github" => "https://github.com/mtanzi/exparticle"}]
  end

  defp deps do
    [
      {:httpoison, "~> 0.8.0"},
      {:poison, "~> 1.5"},
      {:exvcr, "~> 0.7.0", only: [:dev, :test]},
      {:ex_doc, "~> 0.11.2", only: [:dev, :docs]},
      {:inch_ex, "~> 0.4.0", only: [:dev, :docs]},
      {:credo, "~> 0.2.5", only: :dev}
    ]
  end
end

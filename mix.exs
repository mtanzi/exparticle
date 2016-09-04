defmodule ExParticle.Mixfile do
  use Mix.Project

  def project do
    [
      app: :exparticle,
      version: "0.0.5",
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
    ExParticle is an elixir client to communicate with Particle Cloud API
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
      {:poison, "~> 2.2"},
      {:exvcr, "~> 0.8.2", only: [:dev, :test]},
      {:ex_doc, "~> 0.13.0", only: [:dev, :docs]},
      {:inch_ex, "~> 0.5.3", only: [:dev, :docs]},
      {:credo, "~> 0.4.11", only: :dev}
    ]
  end
end

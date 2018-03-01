defmodule ExAch.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :ex_ach,
      version: @version,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:earmark, "~> 1.2", only: :dev},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      source_url: "https://github.com/hollar/ex_ach",
      source_ref: "v#{@version}"
    ]
  end

  defp description do
    """
    ACH (Automated Clearing House) file builder.
    """
  end

  defp package do
    [
      maintainers: ["Nicolas Charlery", "Nicholas Henry", "Tetiana Dushenkivska"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/hollar/ex_ach"}
    ]
  end
end

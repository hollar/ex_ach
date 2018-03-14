defmodule ExAch.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :ex_ach,
      version: @version,
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      aliases: aliases(),
      description: description(),
      package: package(),
      dialyzer: [plt_add_deps: :transitive, ignore_warnings: "dialyzer.ignore-warnings"],
      preferred_cli_env: ["project.check": :test],
      consolidate_protocols: Mix.env() != :test
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:earmark, "~> 1.2", only: :dev},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false},
      {:exprintf, "0.2.1"}
    ]
  end

  defp docs do
    [
      source_url: "https://github.com/hollar/ex_ach",
      source_ref: "v#{@version}",
      main: "ExAch"
    ]
  end

  defp description do
    """
    ACH (Automated Clearing House) file builder.
    """
  end

  defp aliases do
    [
      "project.check": [
        "compile --force --warnings-as-errors",
        "test",
        "dialyzer"
      ]
    ]
  end

  defp package do
    [
      maintainers: ["Nicolas Charlery", "Nicholas Henry", "Tetiana Dushenkivska"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/hollar/ex_ach"}
    ]
  end
end

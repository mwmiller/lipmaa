defmodule Lipmaa.MixProject do
  use Mix.Project

  def project do
    [
      app: :lipmaa,
      version: "1.1.1",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      name: "Lipmaa",
      source_url: "https://github.com/mwmiller/lipmaa",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    Lipmaa - a pure Elixir back-link generator
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Matt Miller"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/mwmiller/lipmaa",
        "Use in Bamboo" => "https://github.com/AljoschaMeyer/bamboo#links-and-entry-verification",
        "Original thesis" => "https://kodu.ut.ee/~lipmaa/papers/thesis/thesis.pdf"
      }
    ]
  end
end

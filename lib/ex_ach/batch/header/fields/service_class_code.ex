defmodule ExAch.Batch.Header.Fields.ServiceClassCode do
  defstruct [:content]
  def new(content) when content in [200, 220, 225] do
    {:ok, %__MODULE__{content: content}}
  end

  def new(_), do: {:error, [{:service_class_code, :non_permitted, "Must be 220, 200 or 225"}]}
end

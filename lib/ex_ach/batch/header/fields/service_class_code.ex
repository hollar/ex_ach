defmodule ExAch.Batch.Header.Fields.ServiceClassCode do
  defstruct [:content]
  def new(content) do
    {:ok, %__MODULE__{content: content}}
  end
end

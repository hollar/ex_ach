defmodule ExAch.Batch.Header.Fields.BatchNumber do
  defstruct [:content]
  def new(content) do
    {:ok, %__MODULE__{content: content}}
  end
end

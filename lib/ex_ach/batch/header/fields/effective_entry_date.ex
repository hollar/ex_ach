defmodule ExAch.Batch.Header.Fields.EffectiveEntryDate do
  defstruct [:content]
  def new(content) do
    {:ok, %__MODULE__{content: content}}
  end
end

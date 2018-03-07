defmodule ExAch.Batch.Header.Fields.StandardEntryClassCode do
  defstruct [:content]

  def new(content) do
    {:ok, %__MODULE__{content: content}}
  end
end

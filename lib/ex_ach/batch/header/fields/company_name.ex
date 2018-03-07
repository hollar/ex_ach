defmodule ExAch.Batch.Header.Fields.CompanyName do
  defstruct [:content]
  def new(content) do
    {:ok, %__MODULE__{content: content}}
  end
end

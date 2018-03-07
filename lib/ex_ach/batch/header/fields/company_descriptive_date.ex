defmodule ExAch.Batch.Header.Fields.CompanyDescriptiveDate do
  defstruct [:content]

  def new(content) do
    {:ok, %__MODULE__{content: content}}
  end
end

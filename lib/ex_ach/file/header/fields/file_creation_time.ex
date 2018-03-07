defmodule ExAch.File.Header.Fields.FileCreationTime do
  defstruct [:content]

  def new(content) do
    {:ok, %__MODULE__{content: content}}
  end
end

defmodule ExAch.File.Header.Fields.ImmediateDestinationName do
  defstruct [:content]

  def new(content) do
    {:ok, %__MODULE__{content: content}}
  end
end

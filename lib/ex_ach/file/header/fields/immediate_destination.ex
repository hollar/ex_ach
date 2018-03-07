defmodule ExAch.File.Header.Fields.ImmediateDestination do
  defstruct [:content]

  def new(value) do
    {:ok, %__MODULE__{content: value}}
  end
end

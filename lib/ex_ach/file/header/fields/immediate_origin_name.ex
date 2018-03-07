defmodule ExAch.File.Header.Fields.ImmediateOriginName do
  defstruct [:content]

  def new(name) do
    {:ok, %__MODULE__{content: name}}
  end
end

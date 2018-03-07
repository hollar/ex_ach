defmodule ExAch.Batch do
  defstruct [:header]

  @type t :: %__MODULE__{}

  def new(header) do
    {:ok, %__MODULE__{header: header}}
  end
end

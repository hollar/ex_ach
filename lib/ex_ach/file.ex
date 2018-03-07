defmodule ExAch.File do
  defstruct [:header, :batches]

  def new(header, batches) do
    {:ok, %__MODULE__{header: header, batches: batches}}
  end
end

defmodule ExAch.File.Control.Fields.BatchCount do
  @moduledoc """
  The value of this ﬁeld must be equal to the number of Company/Batch Header Records in the File.
  """
  use ExAch.Field, render: {:numeric, 6}

  alias ExAch.Batch

  @spec new(list(Batch.t())) :: {:ok, t()}
  def new(batches) do
    {:ok, %__MODULE__{content: Enum.count(batches)}}
  end
end

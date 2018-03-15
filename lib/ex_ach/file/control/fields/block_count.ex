defmodule ExAch.File.Control.Fields.BlockCount do
  @moduledoc """
  The value of this ﬁeld must be equal to the number of Company/Batch Header Records in the File.
  """
  use ExAch.Field, render: {:numeric, 6}

  alias ExAch.{Batch, Field}
  alias ExAch.File.Header.Fields.BlockingFactor

  @spec new(list(Batch.t()), BlockingFactor.t()) :: {:ok, t()}
  def new(batches, blocking_factor) do
    blocking_factor = Field.value(blocking_factor)
    minimum_file_block_count = 2

    count =
      round((minimum_file_block_count + total_entry_addenda_count(batches)) / blocking_factor)

    {:ok, %__MODULE__{content: count}}
  end

  defp total_entry_addenda_count(batches) do
    Enum.reduce(batches, 2, fn batch, acc ->
      acc + Field.value(batch.control.entry_addenda_count)
    end)
  end
end

defmodule ExAch.File.Control.Fields.EntryAddendaCount do
  @moduledoc """
  Total number of entry detail and addenda records processed within the file. This field requires
  height positions; right justify and use leading zeros
  """

  use ExAch.Field, render: {:numeric, 8}

  alias ExAch.{Batch, Field}

  @spec new(list(Batch.t())) :: {:ok, t()}
  def new(batches) do
    count =
      batches
      |> Enum.map(fn batch -> Field.value(batch.control.entry_addenda_count) end)
      |> Enum.sum()

    {:ok, %__MODULE__{content: count}}
  end
end

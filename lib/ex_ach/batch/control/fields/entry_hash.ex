defmodule ExAch.Batch.Control.Fields.EntryHash do
  @moduledoc """
  Company/Batth Control Record: The Entry Hash is the sum of all of the Receiving DFI
  Identification fields contained within the Entry Detail Records in a batch.
  The Receiving DFI Identification Field contains the 8-digit routing number of the RDFI.
  The hash is the sum of the 8-digit routing numbers.

  If the turn exceeds 10 characters, the Entry Hash field must be populated with the
  rightmost 10 characters.
  """

  use ExAch.Field

  alias ExAch.{Batch, Field}

  @spec new(list(Batch.Entry.t())) :: {:ok, t()}
  def new(entries) do
    sum =
      entries
      |> calculate_hash
      |> handle_overflow

    {:ok, %__MODULE__{content: sum}}
  end

  defp calculate_hash(batches) do
    batches
    |> Enum.map(&Field.value(&1.receiving_dfi_identification))
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  defp handle_overflow(count) do
    rem(count, 10_000_000_000)
  end
end

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
      |> Enum.map(fn entry ->
        String.to_integer(Field.value(entry.receiving_dfi_identification))
      end)
      |> Enum.sum()
      |> to_string
      |> String.split_at(-10)
      |> elem(1)

    {:ok, %__MODULE__{content: sum}}
  end
end

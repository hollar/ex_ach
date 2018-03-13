defmodule ExAch.Batch.Control.Fields.EntryHash do
  @moduledoc """
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

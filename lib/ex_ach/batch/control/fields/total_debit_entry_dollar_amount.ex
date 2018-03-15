defmodule ExAch.Batch.Control.Fields.TotalDebitEntryDollarAmount do
  @moduledoc """
  The Total Debit Entry Dollar Amount Field contains accumulated Entry Detail debit amounts
  within the batch.
  """
  use ExAch.Field, render: {:numeric, 12}

  alias ExAch.{Batch, Field}
  alias ExAch.Batch.Entry

  @spec new(list(Batch.Entry.t())) :: {:ok, t()}
  def new(entries) do
    sum =
      entries
      |> Enum.filter(&Entry.debit?/1)
      |> Enum.map(&Field.value(&1.amount))
      |> Enum.sum()

    {:ok, %__MODULE__{content: sum}}
  end
end

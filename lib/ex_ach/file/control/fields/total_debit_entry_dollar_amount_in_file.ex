defmodule ExAch.File.Control.Fields.TotalDebitEntryDollarAmountInFile do
  @moduledoc """
  Accumulated Batch Control Record debit totals within a specific File.
  """
  use ExAch.Field, render: {:numeric, 12}

  alias ExAch.{Batch, Field}

  @spec new(list(Batch.t())) :: {:ok, t()}
  def new(batches) do
    sum =
      batches
      |> Enum.map(&Field.value(&1.control.total_debit_entry_dollar_amount))
      |> Enum.sum()

    {:ok, %__MODULE__{content: sum}}
  end
end

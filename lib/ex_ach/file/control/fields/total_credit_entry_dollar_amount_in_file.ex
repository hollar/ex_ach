defmodule ExAch.File.Control.Fields.TotalCreditEntryDollarAmountInFile do
  @moduledoc """
  Accumulated Batch Control Record credit totals within a specific File.
  """
  use ExAch.Field, render: {:numeric, 12}

  alias ExAch.{Batch, Field}

  @spec new(list(Batch.t())) :: {:ok, t()}
  def new(batches) do
    sum =
      batches
      |> Enum.map(&Field.value(&1.control.total_credit_entry_dollar_amount))
      |> Enum.sum()

    {:ok, %__MODULE__{content: sum}}
  end
end

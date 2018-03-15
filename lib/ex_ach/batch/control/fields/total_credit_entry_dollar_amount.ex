defmodule ExAch.Batch.Control.Fields.TotalCreditEntryDollarAmount do
  @moduledoc """
  The Total Credit Entry Dollar Amount Field contains accumulated Entry Detail credit amounts
  within the batch.
  """
  use ExAch.Field, render: {:numeric, 12}

  alias ExAch.{Batch, Field}
  alias ExAch.Batch.Entry

  @spec new(list(Batch.Entry.t())) :: {:ok, t()}
  def new(entries) do
    sum =
      entries
      |> Enum.filter(&Entry.credit?/1)
      |> Enum.map(&Field.value(&1.amount))
      |> Enum.sum()

    {:ok, %__MODULE__{content: sum}}
  end
end

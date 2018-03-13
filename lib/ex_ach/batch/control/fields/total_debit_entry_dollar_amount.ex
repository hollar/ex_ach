defmodule ExAch.Batch.Control.Fields.TotalDebitEntryDollarAmount do
  use ExAch.Field

  alias ExAch.{Batch, Field}
  alias ExAch.Batch.Entry

  @spec new(list(Batch.Entry.t())) :: {:ok, t()}
  def new(entries) do
    sum =
      entries
      |> Enum.filter(fn entry -> Entry.debit?(entry) end)
      |> Enum.map(fn entry -> Field.value(entry.amount) end)
      |> Enum.sum()

    {:ok, %__MODULE__{content: sum}}
  end
end

defmodule ExAch.Batch.Control.Fields.EntryAddendaCount do
  @moduledoc """
  Total number of entry detail and addenda records processed within the batch. This field requires
  six positions; right justify and use leading zeros
  """

  defstruct [:content]

  alias ExAch.Batch

  @type t :: %__MODULE__{}

  @spec new(list(Batch.Entry.t())) :: {:ok, t()}
  def new(entries) do
    addenda_count =
      entries
      |> Enum.map(&Enum.count(&1.addendas))
      |> Enum.sum()

    entry_count = Enum.count(entries)
    count = entry_count + addenda_count

    {:ok, %__MODULE__{content: count}}
  end
end

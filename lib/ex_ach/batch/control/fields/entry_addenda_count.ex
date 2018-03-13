defmodule ExAch.Batch.Control.Fields.EntryAddendaCount do
  @moduledoc """
  Total number of entry detail and addenda records processed within the batch. This field requires
  six positions; right justify and use leading zeros
  """

  defstruct [:content]

  alias ExAch.Batch

  @type t :: %__MODULE__{}

  # TODO: it also includes number of addenda records processed as well as number of entries
  @spec new(list(Batch.Entry.t())) :: t()
  def new(entries) do
    %__MODULE__{content: Enum.count(entries)}
  end
end

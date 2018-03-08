defmodule ExAch.Batch.Control.Fields.EntryAddendaCount do
  @moduledoc """
  The code identifying the Batch Control record is 8.
  """

  defstruct [:content]

  alias ExAch.Batch.Entry

  @type t :: %__MODULE__{}

  @spec new(list(Entry.t())) :: t()
  def new(entries) do
    %__MODULE__{content: Enum.count(entries)}
  end
end

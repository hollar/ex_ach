defmodule ExAch.Batch do
  alias ExAch.Batch
  defstruct [:header, :entries, :control]

  @type t :: %__MODULE__{}

  @doc """
  Creates a new Batch Header structure
  """
  @spec new(Batch.Header.t(), list(Batch.Entry.t())) :: {:ok, t}
  def new(%Batch.Header{} = header, entries) do
    control = Batch.Control.new(header, entries)
    {:ok, %__MODULE__{header: header, entries: entries, control: control}}
  end
end

defmodule ExAch.Batch do
  alias ExAch.Batch
  defstruct [:header, :entries, :control]

  @type t :: %__MODULE__{}

  @doc """
  Creates a new Batch Header structure
  """
  @spec new(Batch.Header.t(), list(Batch.Entry.t())) :: {:ok, t}
  def new(%Batch.Header{} = header, entries) do
    {:ok, control} = Batch.Control.new(header, entries)
    {:ok, %__MODULE__{header: header, entries: entries, control: control}}
  end

  def to_iodata(batch) do
    [
      Batch.Header.to_iodata(batch.header),
      Enum.map(batch.entries, &Batch.Entry.to_iodata(&1)),
      Batch.Control.to_iodata(batch.control)
    ]
  end
end

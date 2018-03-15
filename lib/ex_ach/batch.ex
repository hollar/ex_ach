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
    # [Batch.Header.to_io_data(batch.header), Enum.map(batch.entries, &Batch.Entry.to_iodata(&1))]
    [
      Batch.Header.to_iodata(batch.header),
      "62212345678153342            00000010007777           RECEIVING COMPANY     A10000000000000001",
      "822000000100123456780000000000000000000010001112223334                         123456780000001"
    ]
  end
end

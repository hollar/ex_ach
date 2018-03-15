defmodule ExAch.File do
  defstruct [:header, :batches, :control]

  alias ExAch.{File, Batch, Field}

  @type t :: %__MODULE__{}

  @doc """
  Create new File structure
  """
  @spec new(File.Header.t(), [Batch.t()]) :: {:ok, t}
  def new(%File.Header{} = header, batches) when is_list(batches) do
    {:ok, control} = File.Control.new(batches, header.blocking_factor)

    {:ok, %__MODULE__{header: header, batches: batches, control: control}}
  end

  @spec to_iodata(t()) :: iodata()
  def to_iodata(ach) do
    [
      File.Header.to_iodata(ach.header),
      Enum.map(ach.batches, &Batch.to_iodata(&1)),
      File.Control.to_iodata(ach.control)
    ]
    |> List.flatten()
    |> fill_last_block(ach)
  end

  defp fill_last_block(iodata, ach) do
    blocking_factor = Field.value(ach.header.blocking_factor)
    line_count = line_count(ach)
    record_size = Field.value(ach.header.record_size)

    ExAch.Block.fill(iodata, line_count, blocking_factor, record_size)
  end

  @spec line_count(t()) :: integer
  def line_count(ach) do
    batch_count = Field.value(ach.control.batch_count)
    entry_addenda_count = Field.value(ach.control.entry_addenda_count)

    Enum.sum([batch_count * 2, entry_addenda_count, 2])
  end
end

defmodule ExAch.File.Control do
  @moduledoc """
  The File Control Record contains dollar, Entry, and hash total accumulations from the Company/
  Batch Control Records in the File. This Record also contains counts of the number of blocks and
  the number of batches within the File (or batched data Transmitted to a single destination).
  """

  alias ExAch.Batch

  alias ExAch.File.Control.Fields.{
    BatchCount,
    RecordTypeCode,
    EntryAddendaCount
  }

  defstruct [
    :record_type_code,
    :batch_count,
    :entry_addenda_count
  ]

  @type t :: %__MODULE__{
          batch_count: BatchCount.t(),
          record_type_code: RecordTypeCode.t()
        }

  @doc """
  Create a batch control record
  """
  @spec new(list(Batch.t())) :: {:ok, t()}
  def new(batches) do
    {:ok, batch_count} = BatchCount.new(batches)
    {:ok, entry_addenda_count} = EntryAddendaCount.new(batches)

    control = %__MODULE__{
      record_type_code: RecordTypeCode.new(),
      batch_count: batch_count,
      entry_addenda_count: entry_addenda_count
    }

    {:ok, control}
  end
end

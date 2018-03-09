defmodule ExAch.Batch.Control do
  @moduledoc """
  The Company/Batch Control Record contains the counts, hash totals and total dollar controls for the preceding Entries withing the batch.
  All Entry Detail Records are hashed. Both Entry Detail Record and Addenda Record are included in the Entry/addenda counts.Batch Header and Batch Control are not included.
  """

  alias ExAch.Batch.{Entry, Header}
  alias ExAch.Batch.Control.Fields.{
    RecordTypeCode,
    EntryAddendaCount
  }

  defstruct [
    :record_type_code,
    :service_class_code,
    :entry_addenda_count
  ]

  @type t :: %__MODULE__{}

  @doc """
  Create a batch control record
  """
  @spec new(Header.t(), list(Entry.t())) :: {:ok, t()}
  def new(header, entries) do
    control = %__MODULE__{
      record_type_code: RecordTypeCode.new(),
      service_class_code: header.service_class_code,
      entry_addenda_count: EntryAddendaCount.new(entries)
    }

    {:ok, control}
  end
end

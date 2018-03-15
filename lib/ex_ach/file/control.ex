defmodule ExAch.File.Control do
  @moduledoc """
  The File Control Record contains dollar, Entry, and hash total accumulations from the Company/
  Batch Control Records in the File. This Record also contains counts of the number of blocks and
  the number of batches within the File (or batched data Transmitted to a single destination).
  """
  use ExAch.Record

  alias ExAch.Batch
  alias ExAch.File.Header.Fields.BlockingFactor

  alias ExAch.File.Control.Fields.{
    BatchCount,
    BlockCount,
    EntryAddendaCount,
    EntryHash,
    RecordTypeCode,
    TotalDebitEntryDollarAmountInFile,
    TotalCreditEntryDollarAmountInFile
  }

  defstruct [
    :record_type_code,
    :batch_count,
    :block_count,
    :entry_addenda_count,
    :entry_hash,
    :total_debit_entry_dollar_amount_in_file,
    :total_credit_entry_dollar_amount_in_file
  ]

  @type t :: %__MODULE__{
          batch_count: BatchCount.t(),
          block_count: BlockCount.t(),
          entry_hash: EntryHash.t(),
          record_type_code: RecordTypeCode.t(),
          total_debit_entry_dollar_amount_in_file: TotalDebitEntryDollarAmountInFile.t(),
          total_credit_entry_dollar_amount_in_file: TotalCreditEntryDollarAmountInFile.t()
        }

  @doc """
  Create a batch control record
  """
  @spec new(list(Batch.t()), BlockingFactor.t()) :: {:ok, t()}
  def new(batches, blocking_factor) do
    {:ok, batch_count} = BatchCount.new(batches)
    {:ok, entry_addenda_count} = EntryAddendaCount.new(batches)
    {:ok, entry_hash} = EntryHash.new(batches)

    {:ok, total_debit_entry_dollar_amount_in_file} =
      TotalDebitEntryDollarAmountInFile.new(batches)

    {:ok, total_credit_entry_dollar_amount_in_file} =
      TotalCreditEntryDollarAmountInFile.new(batches)

    {:ok, block_count} = BlockCount.new(batches, blocking_factor)

    control = %__MODULE__{
      record_type_code: RecordTypeCode.new(),
      batch_count: batch_count,
      block_count: block_count,
      entry_addenda_count: entry_addenda_count,
      entry_hash: entry_hash,
      total_debit_entry_dollar_amount_in_file: total_debit_entry_dollar_amount_in_file,
      total_credit_entry_dollar_amount_in_file: total_credit_entry_dollar_amount_in_file
    }

    {:ok, control}
  end

  def to_iodata(control) do
    [
      control.record_type_code,
      control.batch_count,
      control.block_count,
      control.entry_addenda_count,
      control.entry_hash,
      control.total_debit_entry_dollar_amount_in_file,
      control.total_credit_entry_dollar_amount_in_file,
      reserved_field(39)
    ]
    |> Enum.map(&to_string/1)
    |> to_string()
  end
end

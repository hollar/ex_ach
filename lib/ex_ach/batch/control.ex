defmodule ExAch.Batch.Control do
  @moduledoc """
  The Company/Batch Control Record contains the counts, hash totals and total dollar controls for
  the preceding Entries withing the batch.
  All Entry Detail Records are hashed. Both Entry Detail Record and Addenda Record are included
  in the Entry/addenda counts.Batch Header and Batch Control are not included.
  """

  alias ExAch.Batch

  alias ExAch.Batch.Control.Fields.{
    BatchNumber,
    CompanyIdentification,
    EntryAddendaCount,
    EntryHash,
    MessageAuthenticationCode,
    OriginatingDfiIdentification,
    RecordTypeCode,
    ServiceClassCode,
    TotalCreditEntryDollarAmount,
    TotalDebitEntryDollarAmount
  }

  defstruct [
    :record_type_code,
    :service_class_code,
    :entry_addenda_count,
    :company_identification,
    :entry_hash,
    :total_debit_entry_dollar_amount,
    :total_credit_entry_dollar_amount,
    :message_authentication_code,
    :originating_dfi_identification,
    :batch_number
  ]

  @type t :: %__MODULE__{
          batch_number: BatchNumber.t(),
          company_identification: CompanyIdentification.t(),
          entry_addenda_count: EntryAddendaCount.t(),
          entry_hash: EntryHash.t(),
          message_authentication_code: MessageAuthenticationCode.t(),
          originating_dfi_identification: OriginatingDfiIdentification.t(),
          record_type_code: RecordTypeCode.t(),
          service_class_code: ServiceClassCode.t(),
          total_credit_entry_dollar_amount: TotalCreditEntryDollarAmount.t(),
          total_debit_entry_dollar_amount: TotalDebitEntryDollarAmount.t()
        }

  @doc """
  Create a batch control record
  """
  @spec new(Batch.Header.t(), list(Batch.Entry.t())) :: {:ok, t()}
  def new(batch_header, entries) do
    {:ok, entry_hash} = EntryHash.new(entries)
    {:ok, total_debit_entry_dollar_amount} = TotalDebitEntryDollarAmount.new(entries)
    {:ok, total_credit_entry_dollar_amount} = TotalCreditEntryDollarAmount.new(entries)

    control = %__MODULE__{
      record_type_code: RecordTypeCode.new(),
      service_class_code: ServiceClassCode.new(batch_header.service_class_code),
      entry_addenda_count: EntryAddendaCount.new(entries),
      company_identification: CompanyIdentification.new(batch_header.company_identification),
      entry_hash: entry_hash,
      total_debit_entry_dollar_amount: total_debit_entry_dollar_amount,
      total_credit_entry_dollar_amount: total_credit_entry_dollar_amount,
      message_authentication_code: MessageAuthenticationCode.new(),
      originating_dfi_identification:
        OriginatingDfiIdentification.new(batch_header.originating_dfi_identification),
      batch_number: BatchNumber.new(batch_header.batch_number)
    }

    {:ok, control}
  end
end

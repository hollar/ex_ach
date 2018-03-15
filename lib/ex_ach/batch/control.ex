defmodule ExAch.Batch.Control do
  @moduledoc """
  The Company/Batch Control Record contains the counts, hash totals and total dollar controls for
  the preceding Entries withing the batch.
  All Entry Detail Records are hashed. Both Entry Detail Record and Addenda Record are included
  in the Entry/addenda counts.Batch Header and Batch Control are not included.
  """
  use ExAch.Record

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
    {:ok, service_class_code} = ServiceClassCode.copy(batch_header.service_class_code)

    {:ok, originating_dfi_identification} =
      OriginatingDfiIdentification.copy(batch_header.originating_dfi_identification)

    {:ok, entry_addenda_count} = EntryAddendaCount.new(entries)

    {:ok, company_identification} =
      CompanyIdentification.copy(batch_header.company_identification)

    {:ok, batch_number} = BatchNumber.copy(batch_header.batch_number)

    control = %__MODULE__{
      record_type_code: RecordTypeCode.new(),
      service_class_code: service_class_code,
      entry_addenda_count: entry_addenda_count,
      entry_hash: entry_hash,
      total_debit_entry_dollar_amount: total_debit_entry_dollar_amount,
      total_credit_entry_dollar_amount: total_credit_entry_dollar_amount,
      company_identification: company_identification,
      message_authentication_code: MessageAuthenticationCode.new(),
      originating_dfi_identification: originating_dfi_identification,
      batch_number: batch_number
    }

    {:ok, control}
  end

  def to_iodata(control) do
    [
      control.record_type_code,
      control.service_class_code,
      control.entry_addenda_count,
      control.entry_hash,
      control.total_debit_entry_dollar_amount,
      control.total_credit_entry_dollar_amount,
      control.company_identification,
      control.message_authentication_code,
      reserved_field(6),
      control.originating_dfi_identification,
      control.batch_number
    ]
    |> Enum.map(&to_string/1)
    |> to_string()
  end
end

defmodule ExAch.Batch.Entry do
  use ExAch.Record

  alias ExAch.Batch.Entry.Fields.{
    AddendaRecordIndicator,
    Amount,
    CheckDigit,
    DiscretionaryData,
    DfiAccountNumber,
    IdentificationNumber,
    ReceivingCompanyName,
    ReceivingDfiIdentification,
    RecordTypeCode,
    TraceNumber,
    TransactionCode
  }

  @type t :: %__MODULE__{
          addenda_record_indicator: AddendaRecordIndicator.t(),
          amount: Amount.t(),
          check_digit: CheckDigit.t(),
          dfi_account_number: DfiAccountNumber.t(),
          discretionary_data: DiscretionaryData.t() | Field.Optional.t(),
          identification_number: IdentificationNumber.t() | Field.Optional.t(),
          receiving_company_name: ReceivingCompanyName.t(),
          receiving_dfi_identification: ReceivingDfiIdentification.t(),
          record_type_code: RecordTypeCode.t(),
          trace_number: TraceNumber.t(),
          transaction_code: TransactionCode.t(),
          addendas: list()
        }

  defstruct [
    :transaction_code,
    :receiving_dfi_identification,
    :check_digit,
    :dfi_account_number,
    :amount,
    :receiving_company_name,
    :addenda_record_indicator,
    :trace_number,
    :discretionary_data,
    :identification_number,
    :record_type_code,
    :addendas
  ]

  @doc """
  Create a batch entry structure

  ## Options
    * `:identification_number`
    * `:discretionary_data`
  """
  @spec new(
          TransactionCode.t(),
          ReceivingDfiIdentification.t(),
          CheckDigit.t(),
          DfiAccountNumber.t(),
          Amount.t(),
          ReceivingCompanyName.t(),
          AddendaRecordIndicator.t(),
          TraceNumber.t()
        ) :: {:ok, t}
  def new(
        %TransactionCode{} = transaction_code,
        %ReceivingDfiIdentification{} = receiving_dfi_identification,
        %CheckDigit{} = check_digit,
        %DfiAccountNumber{} = dfi_account_number,
        %Amount{} = amount,
        %ReceivingCompanyName{} = receiving_company_name,
        %AddendaRecordIndicator{} = addenda_record_indicator,
        %TraceNumber{} = trace_number,
        opts \\ []
      ) do
    entry = %__MODULE__{
      record_type_code: RecordTypeCode.new(),
      transaction_code: transaction_code,
      receiving_dfi_identification: receiving_dfi_identification,
      check_digit: check_digit,
      dfi_account_number: dfi_account_number,
      amount: amount,
      identification_number: assign_optional(opts, IdentificationNumber),
      receiving_company_name: receiving_company_name,
      discretionary_data: assign_optional(opts, DiscretionaryData),
      addenda_record_indicator: addenda_record_indicator,
      trace_number: trace_number,
      addendas: []
    }

    {:ok, entry}
  end

  def debit?(entry) do
    TransactionCode.debit?(entry.transaction_code)
  end

  def credit?(entry) do
    TransactionCode.credit?(entry.transaction_code)
  end

  def to_iodata(entry) do
    [
      entry.record_type_code,
      entry.transaction_code,
      entry.receiving_dfi_identification,
      entry.check_digit,
      entry.dfi_account_number,
      entry.amount,
      entry.identification_number,
      entry.receiving_company_name,
      entry.discretionary_data,
      entry.addenda_record_indicator,
      entry.trace_number
    ]
    |> Enum.map(&to_string/1)
    |> to_string()
  end
end

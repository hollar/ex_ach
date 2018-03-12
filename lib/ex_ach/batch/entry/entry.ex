defmodule ExAch.Batch.Entry do
  alias ExAch.Batch.Entry.Fields.{
    TransactionCode,
    ReceivingDfiIdentification,
    CheckDigit,
    DfiAccountNumber,
    Amount,
    ReceivingCompanyName,
    AddendaRecordIndicator,
    TraceNumber,
    RecordTypeCode
  }

  @type t :: %__MODULE__{}

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
    :record_type_code
  ]

  @doc """
  Create a batch entry structure
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
      transaction_code: transaction_code,
      receiving_dfi_identification: receiving_dfi_identification,
      check_digit: check_digit,
      dfi_account_number: dfi_account_number,
      amount: amount,
      receiving_company_name: receiving_company_name,
      addenda_record_indicator: addenda_record_indicator,
      trace_number: trace_number,
      discretionary_data: Keyword.get(opts, :discretionary_data),
      identification_number: Keyword.get(opts, :identification_number),
      record_type_code: RecordTypeCode.new()
    }

    {:ok, entry}
  end
end

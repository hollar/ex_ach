defmodule ExAch.Batch.Header do
  alias ExAch.Batch.Header.Fields.{
    ServiceClassCode,
    CompanyName,
    CompanyIdentification,
    StandardEntryClassCode,
    CompanyEntryDescription,
    EffectiveEntryDate,
    BatchNumber,
    OriginatingDfiIdentification,
    RecordTypeCode,
    SettlementDate,
    OriginatorStatusCode
  }

  @type t :: %__MODULE__{}

  defstruct [
    :service_class_code,
    :company_name,
    :company_identification,
    :standard_entry_class_code,
    :company_entry_description,
    :effective_entry_date,
    :batch_number,
    :originating_dfi_identification,
    :company_descriptive_date,
    :company_discretionary_data,
    :record_type_code,
    :settlement_date,
    :originator_status_code
  ]

  @doc """
  Create a batch header structure
  """
  @spec new(
    ServiceClassCode.t,
    CompanyName.t,
    CompanyIdentification.t,
    StandardEntryClassCode.t,
    CompanyEntryDescription.t,
    EffectiveEntryDate.t,
    BatchNumber.t,
    OriginatingDfiIdentification.t,
    Keyword.t
  ) :: {:ok, t}
  def new(
        %ServiceClassCode{} = service_class_code,
        %CompanyName{} = company_name,
        %CompanyIdentification{} = company_identification,
        %StandardEntryClassCode{} = standard_entry_class_code,
        %CompanyEntryDescription{} = company_entry_description,
        %EffectiveEntryDate{} = effective_entry_date,
        %BatchNumber{} = batch_number,
        %OriginatingDfiIdentification{} = originating_dfi_identification,
        opts \\ []
      ) do
    header = %__MODULE__{
      service_class_code: service_class_code,
      company_name: company_name,
      company_identification: company_identification,
      standard_entry_class_code: standard_entry_class_code,
      company_entry_description: company_entry_description,
      effective_entry_date: effective_entry_date,
      batch_number: batch_number,
      originating_dfi_identification: originating_dfi_identification,
      company_descriptive_date: Keyword.get(opts, :company_descriptive_date),
      company_discretionary_data: Keyword.get(opts, :company_discretionary_data),
      record_type_code: RecordTypeCode.new(),
      settlement_date: SettlementDate.new(),
      originator_status_code: OriginatorStatusCode.new()
    }

    {:ok, header}
  end
end

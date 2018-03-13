defmodule ExAch.Batch.Header do
  alias ExAch.Batch.Header.Fields.{
    ServiceClassCode,
    CompanyDescriptiveDate,
    CompanyDiscretionaryData,
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

  @type t :: %__MODULE__{
          batch_number: BatchNumber.t(),
          company_descriptive_date: CompanyDescriptiveDate.t() | nil,
          company_discretionary_data: CompanyDiscretionaryData.t() | nil,
          company_entry_description: CompanyEntryDescription.t(),
          company_identification: CompanyIdentification.t(),
          company_name: CompanyName.t(),
          effective_entry_date: EffectiveEntryDate.t(),
          originating_dfi_identification: OriginatingDfiIdentification.t(),
          originator_status_code: OriginatorStatusCode.t(),
          record_type_code: RecordTypeCode.t(),
          service_class_code: ServiceClassCode.t(),
          settlement_date: SettlementDate.t(),
          standard_entry_class_code: StandardEntryClassCode.t()
        }

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

  ## Options
    * `:company_descriptive_date`
    * `:company_discretionary_data`
  """
  @spec new(
          ServiceClassCode.t(),
          CompanyName.t(),
          CompanyIdentification.t(),
          StandardEntryClassCode.t(),
          CompanyEntryDescription.t(),
          EffectiveEntryDate.t(),
          BatchNumber.t(),
          OriginatingDfiIdentification.t(),
          Keyword.t()
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

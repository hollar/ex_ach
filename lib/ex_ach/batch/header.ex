defmodule ExAch.Batch.Header do
  use ExAch.Record

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
          company_descriptive_date: CompanyDescriptiveDate.t() | Field.Optional.t(),
          company_discretionary_data: CompanyDiscretionaryData.t() | Field.Optional.t(),
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
      record_type_code: RecordTypeCode.new(),
      service_class_code: service_class_code,
      company_name: company_name,
      company_discretionary_data: assign_optional(opts, CompanyDiscretionaryData),
      company_identification: company_identification,
      standard_entry_class_code: standard_entry_class_code,
      company_entry_description: company_entry_description,
      company_descriptive_date: assign_optional(opts, CompanyDescriptiveDate),
      effective_entry_date: effective_entry_date,
      # TODO: convert to optional the settlement date
      settlement_date: SettlementDate.new(),
      originator_status_code: OriginatorStatusCode.new(),
      originating_dfi_identification: originating_dfi_identification,
      batch_number: batch_number
    }

    {:ok, header}
  end

  def to_iodata(header) do
    [
      header.record_type_code,
      header.service_class_code,
      header.company_name,
      header.company_discretionary_data,
      header.company_identification,
      header.standard_entry_class_code,
      header.company_entry_description,
      header.company_descriptive_date,
      header.effective_entry_date,
      header.settlement_date,
      header.originator_status_code,
      header.originating_dfi_identification,
      header.batch_number
    ]
    |> Enum.map(&to_string/1)
    |> to_string()
  end
end

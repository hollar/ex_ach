defmodule ExAch.Batch.HeaderTest do
  use ExUnit.Case

  alias ExAch.Batch.Header.Fields.{
    ServiceClassCode,
    CompanyName,
    CompanyIdentification,
    StandardEntryClassCode,
    CompanyEntryDescription,
    EffectiveEntryDate,
    BatchNumber,
    OriginatingDfiIdentification,
    CompanyDescriptiveDate,
    CompanyDiscretionaryData,
    RecordTypeCode,
    SettlementDate,
    OriginatorStatusCode
  }

  describe "creating batch header" do
    test "batch header created successfully" do
      {:ok, service_class_code} = ServiceClassCode.new(220)
      {:ok, company_name} = CompanyName.new("CompanyName")
      {:ok, company_identification} = CompanyIdentification.new(1_112_223_334)
      {:ok, standard_entry_class_code} = StandardEntryClassCode.new(:web)
      {:ok, company_entry_description} = CompanyEntryDescription.new("DESC1")
      {:ok, effective_entry_date} = EffectiveEntryDate.new(~D[2000-01-01])
      {:ok, batch_number} = BatchNumber.new(1_234_567)
      {:ok, originating_dfi_identification} = OriginatingDfiIdentification.new(12_345_678)

      # #Optional
      {:ok, company_descriptive_date} = CompanyDescriptiveDate.new(~D[2000-01-01])
      {:ok, company_discretionary_data} = CompanyDiscretionaryData.new("Data1")

      assert standard_entry_class_code.content == :web
      assert company_entry_description.content == "DESC1"
      assert effective_entry_date.content == ~D[2000-01-01]
      assert batch_number.content == 1_234_567
      assert originating_dfi_identification.content == 12_345_678
      assert company_descriptive_date.content == ~D[2000-01-01]
      assert company_discretionary_data.content == "Data1"

      {:ok, batch_header} =
        ExAch.Batch.Header.new(
          service_class_code,
          company_name,
          company_identification,
          standard_entry_class_code,
          company_entry_description,
          effective_entry_date,
          batch_number,
          originating_dfi_identification,
          company_descriptive_date: company_descriptive_date,
          company_discretionary_data: company_discretionary_data
        )

      # Mandatory fields required to be passed by user
      assert batch_header.service_class_code == service_class_code
      assert batch_header.company_name == company_name
      assert batch_header.company_identification == company_identification
      assert batch_header.standard_entry_class_code == standard_entry_class_code
      assert batch_header.company_entry_description == company_entry_description
      assert batch_header.effective_entry_date == effective_entry_date
      assert batch_header.batch_number == batch_number
      assert batch_header.originating_dfi_identification == originating_dfi_identification

      # Optional fields passed by user
      assert batch_header.company_descriptive_date == company_descriptive_date
      assert batch_header.company_discretionary_data == company_discretionary_data

      # Mandatory fields generated by library
      assert batch_header.record_type_code == %RecordTypeCode{content: 5}
      assert batch_header.settlement_date == %SettlementDate{content: ""}
      assert batch_header.originator_status_code == %OriginatorStatusCode{content: 1}
    end
  end
end

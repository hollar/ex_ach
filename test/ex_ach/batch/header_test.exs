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
    CompanyDiscretionaryData
  }

  describe "creating batch header" do
    test "batch header created successfully" do
      {:ok, service_class_code} = ServiceClassCode.new(220)
      {:ok, company_name} = CompanyName.new("CompanyName")
      {:ok, company_identification} = CompanyIdentification.new(1_112_223_334)
      {:ok, standard_entry_class_code} = StandardEntryClassCode.new(:ccd)
      {:ok, company_entry_description} = CompanyEntryDescription.new("DESC1")
      {:ok, effective_entry_date} = EffectiveEntryDate.new(~D[2000-01-01])
      {:ok, batch_number} = BatchNumber.new(1_234_567)
      {:ok, originating_dfi_identification} = OriginatingDfiIdentification.new(7_200_080)

      # #Optional
      {:ok, company_descriptive_date} = CompanyDescriptiveDate.new(~D[2000-01-01])
      {:ok, company_discretionary_data} = CompanyDiscretionaryData.new("Data1")

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
      assert ExAch.Field.value(batch_header.record_type_code) == 5
      assert ExAch.Field.value(batch_header.settlement_date) == ""
      assert ExAch.Field.value(batch_header.originator_status_code) == 1
    end
  end
end

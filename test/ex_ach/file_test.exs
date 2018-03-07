defmodule ExAch.FileTest do
  use ExUnit.Case

  alias ExAch.{File, Batch}

  describe "creating an ach file" do
    test "creates file with header" do
      {:ok, immediate_destination} = File.Header.Fields.ImmediateDestination.new("b071000505")
      {:ok, immediate_origin} = File.Header.Fields.ImmediateOrigin.new("b071000505")
      {:ok, creation_date} = File.Header.Fields.FileCreationDate.new(~D[2000-01-01])
      {:ok, file_id_modifier} = File.Header.Fields.FileIdModifier.new("1")

      {:ok, file_header} =
        File.Header.new(
          immediate_destination,
          immediate_origin,
          creation_date,
          file_id_modifier
        )

      {:ok, service_class_code} = Batch.Header.Fields.ServiceClassCode.new(220)
      {:ok, company_name} = Batch.Header.Fields.CompanyName.new("CompanyName")
      {:ok, company_identification} = Batch.Header.Fields.CompanyIdentification.new(1_112_223_334)
      {:ok, standard_entry_class_code} = Batch.Header.Fields.StandardEntryClassCode.new("WEB")
      {:ok, company_entry_description} = Batch.Header.Fields.CompanyEntryDescription.new("DESC1")
      {:ok, effective_entry_date} = Batch.Header.Fields.EffectiveEntryDate.new(~D[2000-01-01])
      {:ok, batch_number} = Batch.Header.Fields.BatchNumber.new(1_234_567)

      {:ok, originating_dfi_identification} =
        Batch.Header.Fields.OriginatingDfiIdentification.new(12_345_678)

      {:ok, batch_header} =
        ExAch.Batch.Header.new(
          service_class_code,
          company_name,
          company_identification,
          standard_entry_class_code,
          company_entry_description,
          effective_entry_date,
          batch_number,
          originating_dfi_identification
        )

      {:ok, batch} = ExAch.Batch.new(batch_header)
      batches = [batch]

      {:ok, ach} = ExAch.File.new(file_header, batches)

      assert ach.header == file_header
      assert ach.batches == batches
    end
  end
end

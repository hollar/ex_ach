defmodule ExAch.FileTest do
  use ExUnit.Case

  alias ExAch.{File, Batch}

  describe "creating an ach file" do
    test "creates file with header" do
      # File Header params
      {:ok, immediate_destination} = File.Header.Fields.ImmediateDestination.new(171_000_505)
      {:ok, immediate_origin} = File.Header.Fields.ImmediateOrigin.new(123_456_789)
      {:ok, file_id_modifier} = File.Header.Fields.FileIdModifier.new("1")

      {:ok, file_header} =
        File.Header.new(
          immediate_destination,
          immediate_origin,
          file_id_modifier
        )

      # Batch Header params
      {:ok, service_class_code} = Batch.Header.Fields.ServiceClassCode.new(220)
      {:ok, company_name} = Batch.Header.Fields.CompanyName.new("CompanyName")
      {:ok, company_identification} = Batch.Header.Fields.CompanyIdentification.new(1_112_223_334)
      {:ok, standard_entry_class_code} = Batch.Header.Fields.StandardEntryClassCode.new(:ccd)
      {:ok, company_entry_description} = Batch.Header.Fields.CompanyEntryDescription.new("DESC1")
      {:ok, effective_entry_date} = Batch.Header.Fields.EffectiveEntryDate.new(~D[2000-01-01])
      {:ok, batch_number} = Batch.Header.Fields.BatchNumber.new(1_234_567)

      {:ok, originating_dfi_identification} =
        Batch.Header.Fields.OriginatingDfiIdentification.new(7_100_050)

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

      # Batch Entry params
      {:ok, transaction_code} = Batch.Entry.Fields.TransactionCode.new(22)

      {:ok, receiving_dfi_identification} =
        Batch.Entry.Fields.ReceivingDfiIdentification.new("TTTTAAAA")

      {:ok, check_digit} = Batch.Entry.Fields.CheckDigit.new(1)
      {:ok, dfi_account_number} = Batch.Entry.Fields.DfiAccountNumber.new("a12333")
      {:ok, amount} = Batch.Entry.Fields.Amount.new(1000)

      {:ok, receiving_company_name} =
        Batch.Entry.Fields.ReceivingCompanyName.new("receiving company")

      {:ok, addenda_record_indicator} = Batch.Entry.Fields.AddendaRecordIndicator.new(0)
      {:ok, trace_number} = Batch.Entry.Fields.TraceNumber.new(333_000)

      {:ok, batch_entry} =
        ExAch.Batch.Entry.new(
          transaction_code,
          receiving_dfi_identification,
          check_digit,
          dfi_account_number,
          amount,
          receiving_company_name,
          addenda_record_indicator,
          trace_number
        )

      batch_entries = [batch_entry]
      {:ok, batch} = ExAch.Batch.new(batch_header, batch_entries)
      batches = [batch]

      {:ok, ach} = ExAch.File.new(file_header, batches)

      assert ach.header == file_header
      assert ach.batches == batches
      first_batch = List.first(ach.batches)
      assert first_batch.entries == batch_entries
    end
  end
end

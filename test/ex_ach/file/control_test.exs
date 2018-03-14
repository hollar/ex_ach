defmodule ExAch.File.ControlTest do
  use ExUnit.Case

  alias ExAch.{Batch, Field}
  alias ExAch.Batch.Entry
  alias ExAch.File.Control

  alias ExAch.File.Control.Fields.{
    RecordTypeCode
  }

  setup do
    {:ok, service_class_code} = Batch.Header.Fields.ServiceClassCode.new(225)
    {:ok, company_name} = Batch.Header.Fields.CompanyName.new("CompanyName")
    {:ok, company_identification} = Batch.Header.Fields.CompanyIdentification.new(1_112_223_334)
    {:ok, standard_entry_class_code} = Batch.Header.Fields.StandardEntryClassCode.new(:ccd)
    {:ok, company_entry_description} = Batch.Header.Fields.CompanyEntryDescription.new("DESC1")
    {:ok, effective_entry_date} = Batch.Header.Fields.EffectiveEntryDate.new(~D[2000-01-01])
    {:ok, batch_number} = Batch.Header.Fields.BatchNumber.new(1_234_567)

    {:ok, originating_dfi_identification} =
      Batch.Header.Fields.OriginatingDfiIdentification.new("07100050")

    {:ok, batch_header} =
      Batch.Header.new(
        service_class_code,
        company_name,
        company_identification,
        standard_entry_class_code,
        company_entry_description,
        effective_entry_date,
        batch_number,
        originating_dfi_identification
      )

    {:ok, transaction_code} = Entry.Fields.TransactionCode.new(27)
    {:ok, receiving_dfi_identification} = Entry.Fields.ReceivingDfiIdentification.new("12345678")
    {:ok, check_digit} = Entry.Fields.CheckDigit.new(1)
    {:ok, dfi_account_number} = Entry.Fields.DfiAccountNumber.new("a12333")
    {:ok, amount} = Entry.Fields.Amount.new(1000)
    {:ok, receiving_company_name} = Entry.Fields.ReceivingCompanyName.new("receiving company")
    {:ok, addenda_record_indicator} = Entry.Fields.AddendaRecordIndicator.new(0)
    {:ok, trace_number} = Entry.Fields.TraceNumber.new(333_000)

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

    batch_entries = List.wrap(batch_entry)

    {:ok, batch} = ExAch.Batch.new(batch_header, batch_entries)

    [batches: [batch]]
  end

  describe "creating a file control" do
    test "file control created successfully", %{batches: batches} do
      {:ok, file_control} = ExAch.File.Control.new(batches)

      assert %Control{} = file_control
      assert Field.module(file_control.record_type_code) == RecordTypeCode
      assert Field.value(file_control.record_type_code) == 8
    end
  end

  describe "infering batch count" do
    test "a single entry returns 1", %{batches: batches} do
      {:ok, file_control} = ExAch.File.Control.new(batches)
      assert Field.value(file_control.batch_count) == 1
    end
  end
end

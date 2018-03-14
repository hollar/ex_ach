defmodule ExAch.Batch.ControlTest do
  use ExUnit.Case

  alias ExAch.Field
  alias ExAch.Batch.{Header, Control, Entry}

  alias ExAch.Batch.Control.Fields.{
    RecordTypeCode,
    EntryAddendaCount,
    EntryHash,
    MessageAuthenticationCode
  }

  setup do
    {:ok, service_class_code} = Header.Fields.ServiceClassCode.new(225)
    {:ok, company_name} = Header.Fields.CompanyName.new("CompanyName")
    {:ok, company_identification} = Header.Fields.CompanyIdentification.new(1_112_223_334)
    {:ok, standard_entry_class_code} = Header.Fields.StandardEntryClassCode.new(:ccd)
    {:ok, company_entry_description} = Header.Fields.CompanyEntryDescription.new("DESC1")
    {:ok, effective_entry_date} = Header.Fields.EffectiveEntryDate.new(~D[2000-01-01])
    {:ok, batch_number} = Header.Fields.BatchNumber.new(1_234_567)

    {:ok, originating_dfi_identification} =
      Header.Fields.OriginatingDfiIdentification.new("07100050")

    {:ok, batch_header} =
      Header.new(
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

    [batch_header: batch_header, batch_entries: batch_entries]
  end

  describe "creating a batch control" do
    test "batch control created successfully", %{
      batch_header: batch_header,
      batch_entries: batch_entries
    } do
      {:ok, batch_control} = ExAch.Batch.Control.new(batch_header, batch_entries)

      assert %Control{} = batch_control
      assert Field.module(batch_control.record_type_code) == RecordTypeCode
      assert Field.value(batch_control.record_type_code) == 8
      assert Field.module(batch_control.message_authentication_code) == MessageAuthenticationCode
      assert Field.value(batch_control.message_authentication_code) == ""
    end
  end

  describe "infering service_class_code from the batch header" do
    test "debit-only entries returns 225", %{batch_header: batch_header} do
      {:ok, header_service_class_code} = Header.Fields.ServiceClassCode.new(225)

      batch_header = %{batch_header | service_class_code: header_service_class_code}

      {:ok, batch_control} = Control.new(batch_header, [])
      assert Field.value(batch_control.service_class_code) == 225
    end

    test "debit-only entries returns 200", %{batch_header: batch_header} do
      {:ok, header_service_class_code} = Header.Fields.ServiceClassCode.new(220)

      batch_header = %{batch_header | service_class_code: header_service_class_code}

      {:ok, batch_control} = Control.new(batch_header, [])
      assert Field.value(batch_control.service_class_code) == 220
    end
  end

  describe "infering company_identification from the batch header" do
    test "company_identification is copied from header", %{batch_header: batch_header} do
      {:ok, batch_control} = Control.new(batch_header, [])
      assert Field.value(batch_control.company_identification) == 1_112_223_334
    end
  end

  describe "infering entry/addenda count" do
    test "a single entry returns 1", %{batch_header: batch_header, batch_entries: batch_entries} do
      {:ok, batch_control} = Control.new(batch_header, batch_entries)
      assert Field.value(batch_control.entry_addenda_count) == 1
      assert Field.module(batch_control.entry_addenda_count) == EntryAddendaCount
    end
  end

  describe "adding entry hash" do
    test "adds an entry hash", %{batch_header: batch_header, batch_entries: batch_entries} do
      {:ok, batch_control} = Control.new(batch_header, batch_entries)
      assert Field.module(batch_control.entry_hash) == EntryHash
    end
  end

  describe "adding total debit entry dollar amount" do
    test "adds the total debit", %{batch_header: batch_header, batch_entries: batch_entries} do
      {:ok, batch_control} = Control.new(batch_header, batch_entries)
      assert Field.value(batch_control.total_debit_entry_dollar_amount) == 1000
    end
  end

  describe "adding total credit entry dollar amount" do
    test "adds the total credit", %{batch_header: batch_header, batch_entries: batch_entries} do
      {:ok, batch_control} = Control.new(batch_header, batch_entries)
      assert Field.value(batch_control.total_credit_entry_dollar_amount) == 0
    end
  end

  describe "infering originating_dfi_identification from the batch header" do
    test "originating_dfi_identification is copied from header", %{batch_header: batch_header} do
      {:ok, batch_control} = Control.new(batch_header, [])
      assert Field.value(batch_control.originating_dfi_identification) == "07100050"
    end
  end

  describe "infering batch_number from the batch header" do
    test "batch_number is copied from header", %{batch_header: batch_header} do
      {:ok, batch_control} = Control.new(batch_header, [])
      assert Field.value(batch_control.batch_number) == 1_234_567
    end
  end
end

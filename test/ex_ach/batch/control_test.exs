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
    {:ok, header_service_class_code} = Header.Fields.ServiceClassCode.new(225)
    batch_header = %ExAch.Batch.Header{service_class_code: header_service_class_code}

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
    test "debit-only entries returns 225" do
      {:ok, header_service_class_code} = Header.Fields.ServiceClassCode.new(225)
      header = %ExAch.Batch.Header{service_class_code: header_service_class_code}

      {:ok, batch_control} = Control.new(header, [])
      assert batch_control.service_class_code.content == 225
    end

    test "debit-only entries returns 200" do
      {:ok, header_service_class_code} = Header.Fields.ServiceClassCode.new(200)
      header = %ExAch.Batch.Header{service_class_code: header_service_class_code}

      {:ok, batch_control} = Control.new(header, [])
      assert batch_control.service_class_code.content == 200
    end
  end

  describe "infering company_identification from the batch header" do
    test "company_identification is copied from header" do
      {:ok, company_identification} = Header.Fields.CompanyIdentification.new(1_234_567_890)
      header = %ExAch.Batch.Header{company_identification: company_identification}

      {:ok, batch_control} = Control.new(header, [])
      assert batch_control.company_identification.content == 1_234_567_890
    end
  end

  describe "infering entry/addenda count" do
    test "a single entry returns 1", %{batch_header: batch_header, batch_entries: batch_entries} do
      {:ok, batch_control} = Control.new(batch_header, batch_entries)
      assert %EntryAddendaCount{content: 1} = batch_control.entry_addenda_count
    end
  end

  describe "adding entry hash" do
    test "adds an entry hash", %{batch_header: batch_header, batch_entries: batch_entries} do
      {:ok, batch_control} = Control.new(batch_header, batch_entries)

      assert %EntryHash{} = batch_control.entry_hash
    end
  end

  describe "adding total debit entry dollar amount" do
    test "adds the total debit", %{batch_header: batch_header, batch_entries: batch_entries} do
      {:ok, batch_control} = Control.new(batch_header, batch_entries)
      assert Field.value(batch_control.total_debit_entry_dollar_amount) == 1000
    end
  end
end

defmodule ExAch.Batch.ControlTest do
  use ExUnit.Case

  alias ExAch.Batch.{Header, Entry, Control}
  alias ExAch.Batch.Control.Fields.{
    RecordTypeCode,
    EntryAddendaCount
  }

  setup do
    {:ok, header_service_class_code} = Header.Fields.ServiceClassCode.new(225)
    batch_header = %ExAch.Batch.Header{service_class_code: header_service_class_code}
    batch_entries = List.wrap(%Entry{})

    [batch_header: batch_header, batch_entries: batch_entries]
  end

  describe "creating a batch control" do
    test "batch control created successfully", %{batch_header: batch_header, batch_entries: batch_entries} do
      {:ok, batch_control} = ExAch.Batch.Control.new(batch_header, batch_entries)

      assert %Control{} = batch_control
      assert batch_control.record_type_code == %RecordTypeCode{content: 8}
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
      {:ok, company_identification} = Header.Fields.CompanyIdentification.new(1234567890)
      header = %ExAch.Batch.Header{company_identification: company_identification}

      {:ok, batch_control} = Control.new(header, [])
      assert batch_control.company_identification.content == 1234567890
    end
  end

  describe "infering entry/addenda count" do
    test "a single entry returns 1", %{batch_header: batch_header, batch_entries: batch_entries} do
      {:ok, batch_control} = Control.new(batch_header, batch_entries)
      assert %EntryAddendaCount{content: 1} = batch_control.entry_addenda_count
    end
  end
end

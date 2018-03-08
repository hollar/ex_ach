defmodule ExAch.Batch.ControlTest do
  use ExUnit.Case

  alias ExAch.Batch.{Header, Entry, Control}
  alias ExAch.Batch.Control.Fields.{
    RecordTypeCode,
    ServiceClassCode,
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
      assert %ServiceClassCode{content: 225} = batch_control.service_class_code
    end

    test "debit-only entries returns 200" do
      {:ok, header_service_class_code} = Header.Fields.ServiceClassCode.new(200)
      header = %ExAch.Batch.Header{service_class_code: header_service_class_code}

      {:ok, batch_control} = Control.new(header, [])
      assert %ServiceClassCode{content: 200} = batch_control.service_class_code
    end
  end

  describe "infering entry/addenda count" do
    test "a single entry returns 1", %{batch_header: batch_header, batch_entries: batch_entries} do
      {:ok, batch_control} = Control.new(batch_header, batch_entries)
      assert %EntryAddendaCount{content: 1} = batch_control.entry_addenda_count
    end
  end
end

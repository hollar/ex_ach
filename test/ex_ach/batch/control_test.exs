defmodule ExAch.Batch.ControlTest do
  use ExUnit.Case

  alias ExAch.Batch
  alias ExAch.Batch.Control.Fields.{
    RecordTypeCode,
    EntryAddendaCount
  }

  describe "creating a batch control" do
    test "batch control created successfully" do
      # Batch Header params
      {:ok, header_service_class_code} = Batch.Header.Fields.ServiceClassCode.new(225)

      batch_header = %Batch.Header{service_class_code: header_service_class_code}
      batch_entries = List.wrap(%Batch.Entry{})

      {:ok, batch_control} = Batch.Control.new(batch_header, batch_entries)

      assert batch_control
      assert batch_control.record_type_code == %RecordTypeCode{content: 8}
      assert batch_control.service_class_code == header_service_class_code
      assert batch_control.entry_addenda_count == %EntryAddendaCount{content: 1}
    end
  end
end

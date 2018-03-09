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
      {:ok, service_class_code} = Batch.Header.Fields.ServiceClassCode.new(225)
      {:ok, company_identification} = Batch.Header.Fields.CompanyIdentification.new(1_112_223_334)

      batch_header = %Batch.Header{
        service_class_code: service_class_code,
        company_identification: company_identification
      }
      batch_entries = List.wrap(%Batch.Entry{})

      {:ok, batch_control} = Batch.Control.new(batch_header, batch_entries)

      assert batch_control
      assert batch_control.record_type_code == %RecordTypeCode{content: 8}
      assert batch_control.service_class_code == service_class_code
      assert batch_control.entry_addenda_count == %EntryAddendaCount{content: 1}
      assert batch_control.company_identification == company_identification
    end
  end
end

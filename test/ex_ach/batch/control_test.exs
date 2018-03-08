defmodule ExAch.Batch.ControlTest do
  use ExUnit.Case

  alias ExAch.Batch.Control
  alias ExAch.Batch.Control.Fields.{RecordTypeCode}

  describe "creating a batch control" do
    test "batch control created successfully" do
      {:ok, batch_entry} = ExAch.Batch.Entry.new()

      {:ok, batch_control} = ExAch.Batch.Control.new(batch_entry)

      assert %Control{} = batch_control
      assert batch_control.record_type_code == %RecordTypeCode{content: 8}
    end
  end
end

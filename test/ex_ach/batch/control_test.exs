defmodule ExAch.Batch.ControlTest do
  use ExUnit.Case

  alias ExAch.Batch.Control
  # alias ExAch.Batch.Control.Fields

  describe "creating a batch control" do
    test "batch control created successfully" do
      {:ok, batch_entry} =
        ExAch.Batch.Entry.new()

      {:ok, batch_control} =
        ExAch.Batch.Control.new(batch_entry)

      assert %Control{} = batch_control
    end
  end
end

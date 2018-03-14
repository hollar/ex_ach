defmodule ExAch.File.Control.Fields.BlockCountTest do
  use ExUnit.Case

  alias ExAch.File.Control.Fields.BlockCount
  alias ExAch.{Batch, File}

  describe "computing block count" do
    test "a blocking factor of 2 return 3 blocks" do
      blocking_factor = %File.Header.Fields.BlockingFactor{content: 2}
      entry_addenda_count = %Batch.Control.Fields.EntryAddendaCount{content: 1}
      control = %Batch.Control{entry_addenda_count: entry_addenda_count}
      batch = %Batch{control: control}
      batches = List.wrap(batch)

      {:ok, block_count} = BlockCount.new(batches, blocking_factor)

      assert ExAch.Field.value(block_count) == 3
    end
  end
end

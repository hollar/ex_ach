defmodule ExAch.File.Control.Fields.EntryHashTest do
  use ExUnit.Case

  alias ExAch.File.Control.Fields.EntryHash
  alias ExAch.Batch

  describe "computing entry hash" do
    test "a sum under the limit returns the sum" do
      entry_hash = %EntryHash{content: 12_345_678}
      control = %Batch.Control{entry_hash: entry_hash}
      batch = %Batch{control: control}
      batches = List.wrap(batch)

      {:ok, entry_hash} = EntryHash.new(batches)

      assert ExAch.Field.value(entry_hash) == 12_345_678
    end

    test "a sum over the limit gets truncated with the 10 rightmost digits" do
      batches =
        Enum.reduce(1..1000, [], fn _i, acc ->
          entry_hash = %EntryHash{content: 91_234_567}
          control = %Batch.Control{entry_hash: entry_hash}
          batch = %Batch{control: control}
          acc ++ [batch]
        end)

      {:ok, entry_hash} = EntryHash.new(batches)

      assert ExAch.Field.value(entry_hash) == 1_234_567_000
    end
  end
end

defmodule ExAch.Batch.Control.Fields.EntryHashTest do
  use ExUnit.Case

  alias ExAch.Batch.Control.Fields.EntryHash
  alias ExAch.Batch.Entry

  describe "computing entry hash" do
    test "a sum under the limit returns the sum" do
      {:ok, receiving_dfi_identification} =
        Entry.Fields.ReceivingDfiIdentification.new("12345678")

      entry = %Entry{receiving_dfi_identification: receiving_dfi_identification}
      batch_entries = List.wrap(entry)
      {:ok, entry_hash} = EntryHash.new(batch_entries)

      assert ExAch.Field.value(entry_hash) == "12345678"
    end

    test "a sum over the limit gets truncated with the 10 rightmost digits" do
      batch_entries =
        Enum.reduce(1..1000, [], fn _i, acc ->
          {:ok, receiving_dfi_identification} =
            Entry.Fields.ReceivingDfiIdentification.new("91234567")

          entry = %Entry{receiving_dfi_identification: receiving_dfi_identification}

          acc ++ [entry]
        end)

      {:ok, entry_hash} = EntryHash.new(batch_entries)

      assert ExAch.Field.value(entry_hash) == "1234567000"
    end
  end
end

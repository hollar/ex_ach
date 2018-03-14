defmodule ExAch.Batch.Control.Fields.EntryAddendaCountTest do
  use ExUnit.Case

  alias ExAch.Batch.Control.Fields.EntryAddendaCount
  alias ExAch.Batch.Entry

  defmodule DummyAddenda do
    defstruct []
  end

  describe "computing entry addenda count" do
    test "entries without addenda returns the sum" do
      first_entry = %Entry{addendas: []}
      second_entry = %Entry{addendas: []}
      batch_entries = [first_entry, second_entry]

      entry_addenda_count = EntryAddendaCount.new(batch_entries)

      assert ExAch.Field.value(entry_addenda_count) == 2
    end

    test "entries with addendas include addendas in the sum" do
      entry = %Entry{addendas: [%DummyAddenda{}]}
      batch_entries = List.wrap(entry)

      entry_addenda_count = EntryAddendaCount.new(batch_entries)

      assert ExAch.Field.value(entry_addenda_count) == 2
    end
  end
end

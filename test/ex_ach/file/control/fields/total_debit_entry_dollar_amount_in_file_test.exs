defmodule ExAch.File.Control.Fields.TotalDebitEntryDollarAmountInFileTest do
  use ExUnit.Case

  alias ExAch.File.Control.Fields.TotalDebitEntryDollarAmountInFile
  alias ExAch.Batch

  describe "computing total debit" do
    test "a debit entry returns its amount" do
      total_debit_entry_dollar_amount = %Batch.Control.Fields.TotalDebitEntryDollarAmount{
        content: 250
      }

      control = %Batch.Control{
        total_debit_entry_dollar_amount: total_debit_entry_dollar_amount
      }

      batch = %Batch{control: control}
      batches = List.wrap(batch)

      {:ok, total_debit_entry_dollar_amount_in_file} =
        TotalDebitEntryDollarAmountInFile.new(batches)

      assert ExAch.Field.value(total_debit_entry_dollar_amount_in_file) == 250
    end
  end
end

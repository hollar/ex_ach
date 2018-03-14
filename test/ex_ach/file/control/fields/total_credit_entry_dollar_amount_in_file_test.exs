defmodule ExAch.File.Control.Fields.TotalCreditEntryDollarAmountInFileTest do
  use ExUnit.Case

  alias ExAch.File.Control.Fields.TotalCreditEntryDollarAmountInFile
  alias ExAch.Batch

  describe "computing total credit" do
    test "a credit entry returns its amount" do
      total_credit_entry_dollar_amount = %Batch.Control.Fields.TotalCreditEntryDollarAmount{
        content: 250
      }

      control = %Batch.Control{
        total_credit_entry_dollar_amount: total_credit_entry_dollar_amount
      }

      batch = %Batch{control: control}
      batches = List.wrap(batch)

      {:ok, total_credit_entry_dollar_amount_in_file} =
        TotalCreditEntryDollarAmountInFile.new(batches)

      assert ExAch.Field.value(total_credit_entry_dollar_amount_in_file) == 250
    end
  end
end

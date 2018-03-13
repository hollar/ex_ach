defmodule ExAch.Batch.Control.Fields.TotalDebitEntryDollarAmountTest do
  use ExUnit.Case

  alias ExAch.Batch.Control.Fields.TotalDebitEntryDollarAmount
  alias ExAch.Batch.Entry

  describe "computing total debit" do
    test "a debit entry returns its amount" do
      {:ok, debit_amount} = Entry.Fields.Amount.new(250)
      {:ok, debit_transaction_code} = Entry.Fields.TransactionCode.new(27)
      debit_entry = %Entry{amount: debit_amount, transaction_code: debit_transaction_code}

      {:ok, credit_amount} = Entry.Fields.Amount.new(133)
      {:ok, credit_transaction_code} = Entry.Fields.TransactionCode.new(22)
      credit_entry = %Entry{amount: credit_amount, transaction_code: credit_transaction_code}

      batch_entries = [debit_entry, credit_entry]

      {:ok, total_debit_entry_dollar_amount} = TotalDebitEntryDollarAmount.new(batch_entries)

      assert ExAch.Field.value(total_debit_entry_dollar_amount) == 250
    end
  end
end

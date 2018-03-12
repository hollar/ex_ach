defmodule ExAch.Batch.EntryTest do
  use ExUnit.Case

  alias ExAch.Batch.Entry.Fields.{
    TransactionCode,
    ReceivingDfiIdentification,
    CheckDigit,
    DfiAccountNumber,
    Amount,
    ReceivingCompanyName,
    AddendaRecordIndicator,
    TraceNumber,
    DiscretionaryData,
    IdentificationNumber
  }

  describe "creating batch entry" do
    test "batch entry created successfully" do
      # Required fields
      {:ok, transaction_code} = TransactionCode.new(22)
      {:ok, receiving_dfi_identification} = ReceivingDfiIdentification.new(12345)
      {:ok, check_digit} = CheckDigit.new(1)
      {:ok, dfi_account_number} = DfiAccountNumber.new("a12333")
      {:ok, amount} = Amount.new(1000)
      {:ok, receiving_company_name} = ReceivingCompanyName.new("receiving company")
      {:ok, addenda_record_indicator} = AddendaRecordIndicator.new(0)
      {:ok, trace_number} = TraceNumber.new(333_000)

      # Optional
      {:ok, discretionary_data} = DiscretionaryData.new("A1")
      {:ok, identification_number} = IdentificationNumber.new("a12345")

      {:ok, batch_entry} =
        ExAch.Batch.Entry.new(
          transaction_code,
          receiving_dfi_identification,
          check_digit,
          dfi_account_number,
          amount,
          receiving_company_name,
          addenda_record_indicator,
          trace_number,
          discretionary_data: discretionary_data,
          identification_number: identification_number
        )

      # Mandatory fields required to be passed by user
      assert batch_entry.transaction_code == transaction_code
      assert batch_entry.receiving_dfi_identification == receiving_dfi_identification
      assert batch_entry.check_digit == check_digit
      assert batch_entry.dfi_account_number == dfi_account_number
      assert batch_entry.amount == amount
      assert batch_entry.receiving_company_name == receiving_company_name
      assert batch_entry.addenda_record_indicator == addenda_record_indicator
      assert batch_entry.trace_number == trace_number

      # Optional fields passed by user
      assert batch_entry.identification_number == identification_number
      assert batch_entry.discretionary_data == discretionary_data

      # Mandatory fields generated by library
      assert ExAch.Field.value(batch_entry.record_type_code) == 6
    end
  end
end

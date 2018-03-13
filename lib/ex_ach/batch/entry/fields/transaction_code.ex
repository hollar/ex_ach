defmodule ExAch.Batch.Entry.Fields.TransactionCode do
  @moduledoc """
  Two digit code identifying the account type at the receiving financial institution:
  22 - Deposit destined for a Checking Account
  23 - Prenotification for a checking credit
  24 - Zero dollar with remittance into a Checking Account
  27 - Debit destined for a Checking Account
  28 - Prenotification for a checking debit
  29 - Zero dollar with remittance into a Checking Account
  32 - Deposit destined for a Savings Account
  33 - Pronotification for a savings credit
  34 - Zero dollar with remittance into a Savings Account
  37 - Debit designed for a Savings Account
  38 - Prenotification for a Savings debit
  39 - Zero dollar with remittance into a Savings Account
  """

  use ExAch.Field,
    specifications: [
      type: :integer,
      inclusion: [22, 23, 24, 27, 28, 29, 32, 33, 34, 37, 38, 39]
    ]
end

defmodule ExAch.Batch.Entry.Fields.TransactionCode do
  @moduledoc """
  Two digit code identifying the account type at the receiving financial institution:
  22 - Demand Account Automated Deposit (Credit)
  23 - Demand Account Pre-notification of Demand Credit (zero-dollar)
  27 - Demand Account Automated Payment (Debit)
  28 - Demand Account Pre-notification of Demand Debit (zero-dollar)
  32 - Savings Account Automated Deposit (Credit)
  33 - Savings Account Pre-notification of Savings Credit (zerodollar)
  37 - Savings Account Automated Payment (Debit)
  38 - Savings Account Pre-notification of Savings Debit (zerodollar)
  """

  use ExAch.Field,
    validation: [
      type: :integer,
      inclusion: [22, 23, 24, 27, 28, 29, 32, 33, 34, 37, 38, 39]
    ]
end

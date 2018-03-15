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
      inclusion: [22, 23, 27, 28, 32, 33, 37, 38]
    ],
    render: {:numeric, 2}

  def debit?(%{content: code}) when code in [27, 28, 37, 38], do: true
  def debit?(_field), do: false

  def credit?(%{content: code}) when code in [22, 23, 32, 33], do: true
  def credit?(_field), do: false
end

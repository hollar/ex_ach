defmodule ExAch.Batch.Header.Fields.StandardEntryClassCode do
  @moduledoc """
  Identifies the entries in the batch.

  Common standard entry class codes are PPD (Prearranged Payments and Deposit entries) for consumer
  items:
  - CCD (Cash Concentration and Disbursement entries)
  - CTX (Corporate Trade Exchange entries) for corporate transactions,
  - TEL (Telephone initiated entries), and
  - WEB (Authorization received via the Internet).
  """

  use ExAch.Field, specifications: [type: :atom, inclusion: [:ccd]]
end

defmodule ExAch.Batch.Entry.Fields.DfiAccountNumber do
  @moduledoc """
  Receiver's account number at their financial institution. Left justify
  """

  use ExAch.Field, validation: [type: :alphameric, max_length: 17]
end

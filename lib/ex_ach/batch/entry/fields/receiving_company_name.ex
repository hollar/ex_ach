defmodule ExAch.Batch.Entry.Fields.ReceivingCompanyName do
  @moduledoc """
  Name of receiver
  """

  use ExAch.Field, validation: [type: :alphameric, max_length: 22]
end

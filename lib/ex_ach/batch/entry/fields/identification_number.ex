defmodule ExAch.Batch.Entry.Fields.IdentificationNumber do
  @moduledoc """
  Receiver's identification number.
  """

  use ExAch.Field, validation: [type: :alphameric, max_length: 15], render: {:string, 15}
end

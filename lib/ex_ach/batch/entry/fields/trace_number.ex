defmodule ExAch.Batch.Entry.Fields.TraceNumber do
  @moduledoc """
  The Bank will assign a trace number. This number will be unique to the transaction and will help
  identify the transaction in case of an inquiry.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field,
    specifications: [
      type: :integer,
      max_length: 15
    ]
end

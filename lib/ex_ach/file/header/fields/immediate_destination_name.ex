defmodule ExAch.File.Header.Fields.ImmediateDestinationName do
  @moduledoc """
  Optional field. For example, LaSalle Bank.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field, specifications: [type: :alpha_numeric, max_length: 23]
end

defmodule ExAch.File.Header.Fields.ImmediateDestinationName do
  @moduledoc """
  Optional field. For example, LaSalle Bank.
  """
  use ExAch.Field, specifications: [type: :string, max_length: 23]
end

defmodule ExAch.File.Header.Fields.ImmediateDestinationName do
  @moduledoc """
  Optional field. For example, LaSalle Bank.
  """

  use ExAch.Field, validation: [type: :alphameric, max_length: 23], render: {:string, 23}
end

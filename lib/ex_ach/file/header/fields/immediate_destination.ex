defmodule ExAch.File.Header.Fields.ImmediateDestination do
  @moduledoc """
  Bank transit routing number. For example, 71000505 for LaSalle
  """
  use ExAch.Field, specifications: [type: :string, max_length: 10]
end

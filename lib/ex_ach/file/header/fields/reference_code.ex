defmodule ExAch.File.Header.Fields.ReferenceCode do
  @moduledoc """
  Optional field you may use to describe input file for internal accounting purposes.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field, specifications: [type: :alpha_numeric, max_length: 8]
end

defmodule ExAch.File.Header.Fields.ReferenceCode do
  @moduledoc """
  Optional field you may use to describe input file for internal accounting purposes.
  """
  use ExAch.Field, specifications: [type: :alpha_num_string, max_length: 8]
end

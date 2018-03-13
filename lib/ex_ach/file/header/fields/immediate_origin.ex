defmodule ExAch.File.Header.Fields.ImmediateOrigin do
  @moduledoc """
  Your 9-digit company routing number.
  The 10 character field begins with a blank in the first position.
  """

  use ExAch.Field, specifications: [type: :integer, length: 9]
end

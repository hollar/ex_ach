defmodule ExAch.File.Header.Fields.ImmediateDestination do
  @moduledoc """
  Rounting number of the ACH operator or receiving point to which the file is being transmitted.
  The 10 character field begins with a blank in the first position.
  """

  use ExAch.Field, validation: [type: :integer, length: 9]
end

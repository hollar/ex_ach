defmodule ExAch.File.Header.Fields.FileCreationDate do
  @moduledoc """
  The date you created the input file.
  """
  use ExAch.Field, specifications: [type: :date]
end

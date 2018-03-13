defmodule ExAch.File.Header.Fields.FileIdModifier do
  @moduledoc """
  Code to distinguish among multiple input files. Label the first (or only) file "A", and continue
  in sequence (A-Z). If more than one file is delivered, they must have different modifiers.
  """

  use ExAch.Field, validation: [type: :file_id_modifier]
end

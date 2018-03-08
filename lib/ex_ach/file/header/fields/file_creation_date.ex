defmodule ExAch.File.Header.Fields.FileCreationDate do
  @moduledoc """
  The date you created the input file.
  """
  use ExAch.Field, default_content: Date.utc_today()
end

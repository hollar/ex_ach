defmodule ExAch.File.Header.Fields.FileCreationDate do
  @moduledoc """
  The date you created the input file.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field, default_content: Date.utc_today()
end

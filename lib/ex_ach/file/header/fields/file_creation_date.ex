defmodule ExAch.File.Header.Fields.FileCreationDate do
  @moduledoc """
  The date you created the input file.
  """

  use ExAch.Field, value: Date.utc_today(), render: :yymmdd
end

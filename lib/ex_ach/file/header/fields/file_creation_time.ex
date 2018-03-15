defmodule ExAch.File.Header.Fields.FileCreationTime do
  @moduledoc """
  Time of day you created the input file. This field is used to distinguish between input files
  if you submit more than one per day. This field is optional
  """

  use ExAch.Field, value: Time.utc_now(), render: :hhmm
end

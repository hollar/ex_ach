defmodule ExAch.Batch.Header.Fields.CompanyIdentification do
  @moduledoc """
  Your 10-digit company number. Identical to the number in field 4 of the File Header Record,
  unless multiple companies/divisions are provided in one transmission.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field, specifications: [type: :integer, length: 10]
end

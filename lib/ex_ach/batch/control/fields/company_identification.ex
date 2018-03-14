defmodule ExAch.Batch.Control.Fields.CompanyIdentification do
  @moduledoc """
  Your 10-digit company number. Identical to the number in field 4 of the File Header Record,
  unless multiple companies/divisions are provided in one transmission.
  """

  use ExAch.Field
  alias ExAch.Batch.Header.Fields.CompanyIdentification

  @spec new(CompanyIdentification.t()) :: {:ok, t()}
  def new(%CompanyIdentification{content: company_identification}),
    do: {:ok, %__MODULE__{content: company_identification}}
end

defmodule ExAch.Batch.Header.Fields.CompanyDiscretionaryData do
  @moduledoc """
  Company discretionary data for your company's internal use, if desired.
  No specific format is required. It's an optional field
  """

  use ExAch.Field, specifications: [type: :alpha_numeric, max_length: 20]
end

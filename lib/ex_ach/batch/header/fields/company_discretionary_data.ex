defmodule ExAch.Batch.Header.Fields.CompanyDiscretionaryData do
  @moduledoc """
  Company discretionary data for your company's internal use, if desired.
  No specific format is required. It's an optional field
  """

  use ExAch.Field, validation: [type: :alphameric, max_length: 20], render: {:string, 20}
end

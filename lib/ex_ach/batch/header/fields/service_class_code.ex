defmodule ExAch.Batch.Header.Fields.ServiceClassCode do
  @moduledoc """
  Identifies the type of entries in the batch:
  200 - ACH Entries Mixed Debits and Credits
  220 - ACH Credits Only
  225 - ACH Debits Only
  """

  use ExAch.Field, validation: [type: :integer, inclusion: [200, 220, 225]]
end

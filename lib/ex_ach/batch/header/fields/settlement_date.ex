defmodule ExAch.Batch.Header.Fields.SettlementDate do
  @moduledoc """
  Leave this field blank
  """

  use ExAch.Field, value: "", render: {:string, 3}
end

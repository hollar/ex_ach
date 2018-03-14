defmodule ExAch.Batch.Control.Fields.ServiceClassCode do
  @moduledoc """
  Identifies the type of entries in the batch:
  200 - ACH Entries Mixed Debits and Credits
  220 - ACH Credits Only
  225 - ACH Debits Only
  """

  use ExAch.Field
  alias ExAch.Batch.Header.Fields.ServiceClassCode

  @spec new(ServiceClassCode.t()) :: {:ok, t()}
  def new(%ServiceClassCode{content: code}), do: {:ok, %__MODULE__{content: code}}
end

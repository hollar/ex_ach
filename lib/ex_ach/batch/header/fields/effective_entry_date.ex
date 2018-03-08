defmodule ExAch.Batch.Header.Fields.EffectiveEntryDate do
  @moduledoc """
  Date transactions are to be posted to the participants’ account
  """
  @type t :: %__MODULE__{}
  use ExAch.Field, specifications: [type: :date]
end

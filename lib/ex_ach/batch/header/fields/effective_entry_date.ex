defmodule ExAch.Batch.Header.Fields.EffectiveEntryDate do
  @moduledoc """
  Date transactions are to be posted to the participants’ account
  """

  use ExAch.Field, validation: [type: :date], render: :yymmdd
end

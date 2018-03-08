defmodule ExAch.Batch.Entry.Fields.AddendaRecordIndicator do
  @moduledoc """
  If there is no addenda accompanying this transaction enter 0. If addenda is accompanying the
  transaction enter 1.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field,
    specifications: [
      type: :integer,
      inclusion: [0, 1]
    ]
end

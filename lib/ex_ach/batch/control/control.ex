defmodule ExAch.Batch.Control do
  @moduledoc """
  The Company/Batch Control Record contains the counts, hash totals and total dollar controls for the preceding Entries withing the batch.
  All Entry Detail Records are hashed. Both Entry Detail Record and Addenda Record are included in the Entry/addenda counts.Batch Header and Batch Control are not included.
  """

  alias ExAch.Batch.Entry
  alias ExAch.Batch.Control.Fields.{
    RecordTypeCode
  }

  defstruct [
    :record_type_code
  ]

  @type t :: %__MODULE__{}

  @doc """
  Create a batch control record
  """
  @spec new(Entry.t()) :: {:ok, t()}
  def new(entry) do
    control = %__MODULE__{
      record_type_code: RecordTypeCode.new()
    }

    {:ok, control}
  end
end

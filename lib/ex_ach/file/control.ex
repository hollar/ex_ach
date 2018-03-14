defmodule ExAch.File.Control do
  @moduledoc """
  The File Control Record contains dollar, Entry, and hash total accumulations from the Company/
  Batch Control Records in the File. This Record also contains counts of the number of blocks and
  the number of batches within the File (or batched data Transmitted to a single destination).
  """

  alias ExAch.Batch

  alias ExAch.File.Control.Fields.{
    RecordTypeCode
  }

  defstruct [
    :record_type_code
  ]

  @type t :: %__MODULE__{
          record_type_code: RecordTypeCode.t()
        }

  @doc """
  Create a batch control record
  """
  @spec new(list(Batch.t())) :: {:ok, t()}
  def new(_batches) do
    control = %__MODULE__{
      record_type_code: RecordTypeCode.new()
    }

    {:ok, control}
  end
end

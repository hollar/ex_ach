defmodule ExAch.Batch.Header.Fields.BatchNumber do
  @moduledoc """
  Number batches sequentially.
  """

  defstruct [:content]

  @length 7
  @specifications [
    {:batch_number, :max_length, @length}
  ]

  def new(content) do
    errors = ExAch.FieldValidator.validate(content, @specifications)

    if Enum.empty?(errors) do
      {:ok, %__MODULE__{content: content}}
    else
      {:error, errors}
    end
  end
end

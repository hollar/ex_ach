defmodule ExAch.Batch.Header.Fields.EffectiveEntryDate do
  @moduledoc """
  Date transactions are to be posted to the participants’ account
  """
  defstruct [:content]

  def new(%Date{} = content) do
    {:ok, %__MODULE__{content: content}}
  end

  def new(_) do
    {:error, [{:effective_entry_date, :format, "Must be a date"}]}
  end
end

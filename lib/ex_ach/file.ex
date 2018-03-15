defmodule ExAch.File do
  defstruct [:header, :batches, :control]

  alias ExAch.{File, Batch}

  @type t :: %__MODULE__{}

  @doc """
  Create new File structure
  """
  @spec new(File.Header.t(), [Batch.t()]) :: {:ok, t}
  def new(%File.Header{} = header, batches) when is_list(batches) do
    {:ok, control} = File.Control.new(batches, header.blocking_factor)

    {:ok, %__MODULE__{header: header, batches: batches, control: control}}
  end

  @spec to_iodata(t()) :: iodata()
  def to_iodata(ach) do
    foo =
      """
      9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999|
      9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999|
      9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999|
      9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999|
      9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
      """
      |> String.replace("|", "")
      |> String.split("\n")

    ([
       File.Header.to_iodata(ach.header),
       Enum.map(ach.batches, &Batch.to_iodata(&1)),
       File.Control.to_iodata(ach.control)
     ] ++ foo)
    |> List.flatten()
  end
end

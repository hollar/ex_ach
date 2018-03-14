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
      5220COMPANYNAME     DATA1               1112223334CCDDESC1     Jan 13000101   1123456780000001|
      62212345678153342            00000010007777           RECEIVING COMPANY     A10000000000000001|
      822000000100123456780000000000000000000010001112223334                         123456780000001|
      9000001000001000000010012345678000000000000000000001000                                       |
      9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999|
      9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999|
      9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999|
      9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999|
      9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
      """
      |> String.replace("|", "")
      |> String.split("\n")

    [File.Header.to_iodata(ach.header)] ++ foo
  end
end

defmodule ExAch.Batch.Header.Fields.CompanyName do
  defstruct [:content]
  @length 16

  def new(content) when byte_size(content) <= @length do
    validate_format(content)
  end

  def new(_content) do
    {:error, [{:company_name, :length, "Must be less than 16 character"}]}
  end

  def validate_format(content) do
    case Regex.match?(~r/^[0-9A-Za-z]+$/, content) do
      true -> {:ok, %__MODULE__{content: content}}
      false -> {:error, [{:company_name, :format, "Must be alphanum"}]}
    end
  end
end

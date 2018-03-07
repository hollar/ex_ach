defmodule ExAch.FieldValidator do
  @moduledoc false

  def validate(content, validations) do
    validations
    |> Enum.map(&do_validate(content, &1))
    |> Enum.reject(fn(value) -> value == nil end)
  end

  defp do_validate(content, {field_name, :format, regex}) do
    if !Regex.match?(regex, content) do
      {field_name, :format, "Must be alphanum"}
    end
  end

  defp do_validate(content, {field_name, :max_length, length}) when is_binary(content) do
    if byte_size(content) > length do
      {field_name, :max_length, "Must be less than #{length} character"}
    end
  end

  defp do_validate(content, {field_name, :length, length}) when is_integer(content) do
    if byte_size(to_string(content)) > length do
      {field_name, :length, "Must be #{length} digits"}
    end
  end
end
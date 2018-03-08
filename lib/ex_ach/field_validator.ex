defmodule ExAch.FieldValidator do
  @moduledoc false

  def validate(content, validations) do
    validations
    |> Enum.map(&do_validate(content, &1))
    |> Enum.reject(fn value -> value == nil end)
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

  defp do_validate(content, {field_name, :max_length, length}) when is_integer(content) do
    if String.length(to_string(content)) > length do
      {field_name, :max_length, "Must be less than #{length} digits"}
    end
  end

  defp do_validate(content, {field_name, :length, length}) when is_integer(content) do
    if String.length(to_string(content)) > length do
      {field_name, :length, "Must be #{length} digits"}
    end
  end

  defp do_validate(content, {field_name, :length, length}) when is_binary(content) do
    if String.length(content) > length do
      {field_name, :length, "Must be #{length} long"}
    end
  end

  defp do_validate(content, {field_name, :inclusion, list}) when is_list(list) do
    if !(content in list) do
      list_s =
        list
        |> Enum.join(",")
        |> to_string

      {field_name, :inclusion, "Must be in [#{list_s}]"}
    end
  end

  defp do_validate(content, {field_name, :type, :string}) when is_integer(content) do
    {field_name, :type, "Must be an alphanum string"}
  end
  defp do_validate(content, {field_name, :type, :string}) when is_binary(content) do
    if !Regex.match?(~r/^[0-9A-Za-z ]+$/, content) do
      {field_name, :format, "Must be alphanum"}
    end
  end

  defp do_validate(%Date{}, {_field_name, :type, :date}), do: nil
  defp do_validate(_content, {field_name, :type, :date}) do
    {field_name, :type, "Must be a date"}
  end

  defp do_validate(content, {_field_name, :type, :integer}) when is_integer(content), do: nil
  defp do_validate(_content, {field_name, :type, :integer}) do
    {field_name, :type, "Must be an integer"}
  end

  defp do_validate(content, {_field_name, :type, :atom}) when is_atom(content), do: nil
  defp do_validate(_content, {field_name, :type, :atom}) do
    {field_name, :type, "Must be an atom"}
  end
end

defmodule ExAch.FileHeader do
  alias ExAch.Field

  defstruct [
    :record_type_code,
    :priority_code,
    :immediate_destination,
    :immediate_origin,
    :file_creation_date,
    :file_creation_time,
    :file_id_modifier,
    :record_size,
    :blocking_factor,
    :format_code,
    :immediate_destination_name,
    :immediate_origin_name,
    :reference_code
  ]

  def new, do: %__MODULE__{}

  def add_fields(file_header, params) do
    file_header
    |> build_record_type_code
    |> build_priority_code
    |> build_immediate_destination(params.immediate_destination)
    |> build_immediate_origin(params.immediate_origin)
    |> build_file_creation_date(params.file_creation_date)
    |> build_file_creation_time(params[:file_creation_time])
    |> build_file_id_modifier(params[:file_id_modifier])
    |> build_record_size
    |> build_blocking_factor
    |> build_format_code
    |> build_immediate_destination_name(params[:immediate_destination_name])
    |> build_immediate_origin_name(params[:immediate_origin_name])
    |> build_reference_code(params.reference_code)
  end

  defp build_record_type_code(file_header) do
    add_field(file_header, :record_type_code, "1", 1, 1)
  end

  defp build_priority_code(file_header) do
    add_field(file_header, :priority_code, "01", 2, 2)
  end

  defp build_immediate_destination(file_header, immediate_destination) do
    add_field(file_header, :immediate_destination, immediate_destination, 4, 10)
  end

  defp build_immediate_origin(file_header, immediate_origin) do
    add_field(file_header, :immediate_origin, immediate_origin, 14, 10)
  end

  defp build_file_creation_date(file_header, file_creation_date) do
    add_field(file_header, :file_creation_date, file_creation_date, 24, 6)
  end

  defp build_file_creation_time(file_header, file_creation_time) do
    add_field(file_header, :file_creation_time, file_creation_time, 30, 4, false)
  end

  defp build_file_id_modifier(file_header, file_id_modifier) do
    add_field(file_header, :file_id_modifier, file_id_modifier, 34, 1)
  end

  defp build_record_size(file_header) do
    add_field(file_header, :record_size, "094", 35, 3)
  end

  defp build_blocking_factor(file_header) do
    add_field(file_header, :blocking_factor, "10", 38, 2)
  end

  defp build_format_code(file_header) do
    add_field(file_header, :format_code, "1", 40, 1)
  end

  defp build_immediate_destination_name(file_header, immediate_destination_name) do
    add_field(file_header, :immediate_destination_name, immediate_destination_name, 41, 23, false)
  end

  defp build_immediate_origin_name(file_header, immediate_origin_name) do
    add_field(file_header, :immediate_origin_name, immediate_origin_name, 64, 23, false)
  end

  defp build_reference_code(file_header, reference_code) do
    add_field(file_header, :reference_code, reference_code, 87, 8)
  end

  defp add_field(file_header, field_name, content, position, length, is_mandatory \\ true) do
    field = Field.create(
      name: field_name,
      content: content,
      length: length,
      position: position,
      is_mandatory: is_mandatory
    )

    Map.put(file_header, field_name, field)
  end
end

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
    |> build_file_creation_time(params.file_creation_time)
    |> build_file_id_modifier(params.file_id_modifier)
    |> build_record_size
    |> build_blocking_factor
    |> build_format_code
    |> build_immediate_destination_name(params.immediate_destination_name)
    |> build_immediate_origin_name(params.immediate_origin_name)
    |> build_reference_code(params.reference_code)
  end

  defp build_record_type_code(file_header) do
    field =
      Field.create(
        name: "Record Type Code",
        content: "1",
        length: 1,
        position: {1, 1}
      )

    %{file_header | record_type_code: field}
  end

  defp build_priority_code(file_header) do
    field =
      Field.create(
        name: "Priority Code",
        content: "01",
        length: 2,
        position: {2, 3}
      )

    %{file_header | priority_code: field}
  end

  defp build_immediate_destination(file_header, immediate_destination_params) do
    field =
      Field.create(
        name: "Immediate Destination",
        content: immediate_destination_params.content,
        length: 10,
        position: {4, 13}
      )

    %{file_header | immediate_destination: field}
  end

  defp build_immediate_origin(file_header, immediate_origin_params) do
    field =
      Field.create(
        name: "Immediate Origin",
        content: immediate_origin_params.content,
        length: 10,
        position: {14, 23}
      )

    %{file_header | immediate_origin: field}
  end

  defp build_file_creation_date(file_header, file_creation_date_params) do
    field =
      Field.create(
        name: "File Creation Date",
        content: file_creation_date_params.content,
        length: 6,
        position: {24, 29}
      )

    %{file_header | file_creation_date: field}
  end

  defp build_file_creation_time(file_header, file_creation_time_params) do
    field =
      Field.create(
        name: "File Creation Time",
        content: file_creation_time_params.content,
        length: 4,
        position: {30, 33},
        is_mandatory: false
      )

    %{file_header | file_creation_time: field}
  end

  defp build_file_id_modifier(file_header, file_id_modifier_params) do
    field =
      Field.create(
        name: "File ID modifier",
        content: file_id_modifier_params.content,
        length: 1,
        position: {34, 34},
        is_mandatory: true
      )

    %{file_header | file_id_modifier: field}
  end

  defp build_record_size(file_header) do
    field =
      Field.create(
        name: "Record Size",
        content: "094",
        length: 3,
        position: {35, 37},
        is_mandatory: true
      )

    %{file_header | record_size: field}
  end

  defp build_blocking_factor(file_header) do
    field =
      Field.create(
        name: "Blocking Factor",
        content: "10",
        length: 2,
        position: {38, 39},
        is_mandatory: true
      )

    %{file_header | blocking_factor: field}
  end

  defp build_format_code(file_header) do
    field =
      Field.create(
        name: "Format Code",
        content: "1",
        length: 1,
        position: {40, 40},
        is_mandatory: true
      )

    %{file_header | format_code: field}
  end

  defp build_immediate_destination_name(file_header, immediate_destination_name_params) do
    field =
      Field.create(
        name: "Immediate Destination Name",
        content: immediate_destination_name_params.content,
        length: 23,
        position: {41, 63},
        is_mandatory: false
      )

    %{file_header | immediate_destination_name: field}
  end

  defp build_immediate_origin_name(file_header, immediate_origin_name_params) do
    field =
      Field.create(
        name: "Immediate Origin Name",
        content: immediate_origin_name_params.content,
        length: 23,
        position: {64, 86},
        is_mandatory: false
      )

    %{file_header | immediate_origin_name: field}
  end

  defp build_reference_code(file_header, reference_code_params) do
    field =
      Field.create(
        name: "Reference Code",
        content: reference_code_params.content,
        length: 8,
        position: {87, 94}
      )

    %{file_header | reference_code: field}
  end
end

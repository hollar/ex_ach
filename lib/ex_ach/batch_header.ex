defmodule ExAch.BatchHeader do
  alias ExAch.Field
  @fields [
    :record_type_code,
    :service_class_code,
    :company_name,
    :company_discretionary_data,
    :company_identification,
    :standard_entry_class_code,
    :company_entry_description,
    :company_descriptive_date,
    :effective_entry_date,
    :settlement_date,
    :originator_status_code,
    :originating_dfi_identification,
    :batch_number
  ]
  defstruct @fields

  def new, do: %__MODULE__{}

  def add_header(header, batch_header_params) do
    header
    |> add_record_type_code
    |> add_service_class_code
    |> add_company_name(batch_header_params.company_name)
    |> add_company_discretionary_data(batch_header_params.company_discretionary_data)
    |> add_company_identification(batch_header_params.company_identification)
    |> add_standard_entry_class_code(batch_header_params.standard_entry_class_code)
    |> add_company_entry_description(batch_header_params.company_entry_description)
    |> add_company_descriptive_date(batch_header_params.company_descriptive_date)
    |> add_effective_entry_date(batch_header_params.effective_entry_date)
    |> add_settlement_date
    |> add_originator_status_code
    |> add_originating_dfi_identification(batch_header_params.originating_dfi_identification)
    |> add_batch_number(batch_header_params.batch_number)
  end

  defp add_record_type_code(header) do
    add_field(header, :record_type_code, "5", 1, 1)
  end

  defp add_service_class_code(header) do
    add_field(header, :service_class_code, "220", 2, 3)
  end

  defp add_company_name(header, company_name) do
    add_field(header, :company_name, company_name, 5, 16)
  end

  defp add_company_discretionary_data(header, company_discretionary_data) do
    add_field(header, :company_discretionary_data, company_discretionary_data, 21, 20, false)
  end

  defp add_company_identification(header, company_identification) do
    add_field(header, :company_identification, company_identification, 41, 10)
  end

  defp add_standard_entry_class_code(header, standard_entry_class_code) do
    add_field(header, :standard_entry_class_code, standard_entry_class_code, 51, 3)
  end

  defp add_company_entry_description(header, company_entry_description) do
    add_field(header, :company_entry_description, company_entry_description, 54, 10)
  end

  defp add_company_descriptive_date(header, company_descriptive_date) do
    add_field(header, :company_descriptive_date, company_descriptive_date, 64, 6, false)
  end

  defp add_effective_entry_date(header, effective_entry_date) do
    add_field(header, :effective_entry_date, effective_entry_date, 70, 6)
  end

  defp add_settlement_date(header) do
    add_field(header, :settlement_date, "", 76, 3)
  end

  defp add_originator_status_code(header) do
    add_field(header, :originator_status_code, "1", 79, 1)
  end

  defp add_originating_dfi_identification(header, originating_dfi_identification) do
    add_field(header, :originating_dfi_identification, originating_dfi_identification, 80, 8)
  end

  defp add_batch_number(header, batch_number) do
    add_field(header, :batch_number, batch_number, 88, 7)
  end


  defp add_field(file_header, field_name, content, position, length, required \\ true)
       when field_name in @fields do
    field =
      Field.create(
        name: field_name,
        content: content,
        length: length,
        position: position,
        required: required
      )

    Map.put(file_header, field_name, field)
  end
end

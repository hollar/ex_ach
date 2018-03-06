defmodule ExAch.BatchHeaderParams do
  @moduledoc false
  use Vex.Struct

  @type t :: %__MODULE__{}

  defstruct [
    :company_name,
    :company_discretionary_data,
    :company_identification,
    :standard_entry_class_code,
    :company_entry_description,
    :company_descriptive_date,
    :effective_entry_date,
    :originating_dfi_identification,
    :batch_number
  ]

  validates(:company_name, presence: true, length: [max: 16], format: ~r/^[[:alnum:]]+$/)
  validates(:company_discretionary_data, length: [max: 20])

  validates(
    :company_identification,
    presence: true,
    length: 10,
    format: ~r/^[[:digit:]]+$/
  )

  validates(
    :standard_entry_class_code,
    presence: true,
    length: 3,
    inclusion: ["CCD", "WEB"],
    format: ~r/^[[:alpha:]]+$/
  )

  validates(
    :company_entry_description,
    presence: true,
    length: [max: 10],
    format: ~r/^[[:alnum:]]+$/
  )

  validates(:company_descriptive_date, length: 6)
  validates(:effective_entry_date, presence: true, length: 6, format: ~r/^[[:digit:]]+$/)

  validates(
    :originating_dfi_identification,
    presence: true,
    length: 8,
    format: ~r/^[[:digit:]]+$/
  )

  validates(:batch_number, presence: true, length: [max: 7], format: ~r/^[[:digit:]]+$/)

  @spec new(map) :: t()
  def new(params) do
    %__MODULE__{
      company_name: params.company_name,
      company_discretionary_data: params[:company_discretionary_data],
      company_identification: params.company_identification,
      standard_entry_class_code: params.standard_entry_class_code,
      company_entry_description: params.company_entry_description,
      company_descriptive_date: company_descriptive_date(params),
      effective_entry_date: params.effective_entry_date,
      originating_dfi_identification: params.originating_dfi_identification,
      batch_number: params.batch_number
    }
  end

  defp company_descriptive_date(params) do
    [<<_first::binary-size(2), last::binary-size(2)>>, month, day] =
      Date.utc_today()
      |> to_string()
      |> String.split("-")

    date = last <> month <> day
    params[:company_descriptive_date] || date
  end
end

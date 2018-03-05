defmodule ExAch.BatchHeaderParams do
  @moduledoc false
  use Vex.Struct

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
  validates(:company_discretionary_data, length: [max: 20], format: ~r/^[[:alnum:] ]+$/)

  validates(
    :company_identification,
    presence: true,
    length: [max: 10],
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
    format: ~r/^[[:alnum:] ]+$/
  )

  validates(:company_descriptive_date, length: 6, format: ~r/^[[:digit:]]+$/)
  validates(:effective_entry_date, presence: true, length: 6, format: ~r/^[[:digit:]]+$/)

  validates(
    :originating_dfi_identification,
    presence: true,
    length: 8,
    format: ~r/^[[:digit:]]+$/
  )

  validates(:batch_number, presence: true, length: [max: 7], format: ~r/^[[:digit:]]+$/)

  @spec new(map) :: %__MODULE__{}
  def new(params) do
    %__MODULE__{
      company_name: params.company_name,
      company_discretionary_data: params[:company_discretionary_data],
      company_identification: params.company_identification,
      standard_entry_class_code: params.standard_entry_class_code,
      company_entry_description: params.company_entry_description,
      company_descriptive_date: params[:company_descriptive_date],
      effective_entry_date: params.effective_entry_date,
      originating_dfi_identification: params.originating_dfi_identification,
      batch_number: params.batch_number
    }
  end
end

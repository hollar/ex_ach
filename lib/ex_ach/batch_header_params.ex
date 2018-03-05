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

  # validates :immediate_destination,
  #   presence: true
  # validates :immediate_origin,
  #   presence: true,
  #   length: 10,
  #   format: ~r/[0-9]{10}/
  # validates :file_creation_date,
  #   presence: true
  # validates :file_id_modifier,
  #   presence: true
  # validates :reference_code,
  #   presence: true
  # validates :immediate_origin_name,
  #   length: [max: 23]

  @spec new(ExAch.file_header_params) :: %__MODULE__{}
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

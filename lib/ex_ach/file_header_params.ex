defmodule ExAch.FileHeaderParams do
  @moduledoc false
  use Vex.Struct
  defstruct [
    :immediate_destination,
    :immediate_destination_name,
    :immediate_origin,
    :immediate_origin_name,
    :file_creation_date,
    :file_creation_time,
    :file_id_modifier,
    :reference_code
  ]

  validates :immediate_destination,
    presence: true
  validates :immediate_origin,
    presence: true,
    length: 10,
    format: ~r/[0-9]{10}/
  validates :file_creation_date,
    presence: true
  validates :file_id_modifier,
    presence: true
  validates :reference_code,
    presence: true
  validates :immediate_origin_name,
    length: [max: 23]

  @spec new(ExAch.file_header_params) :: %__MODULE__{}
  def new(params) do
    %__MODULE__{
      immediate_destination: params.immediate_destination,
      immediate_destination_name: params[:immediate_destination_name],
      immediate_origin: params.immediate_origin,
      immediate_origin_name: params.immediate_origin_name,
      file_creation_date: params.file_creation_date,
      file_creation_time: params[:file_creation_time],
      file_id_modifier: params.file_id_modifier,
      reference_code: params.reference_code
    }
  end
end

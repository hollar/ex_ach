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

  validates(:immediate_destination, presence: true, format: ~r/^[[:alnum:]]+$/)
  validates(:immediate_destination_name, length: [max: 23], format: ~r/^[[:alnum:] ]+$/)

  validates(
    :immediate_origin,
    presence: true,
    length: 10,
    format: ~r/[0-9]{10}/
  )

  validates(:immediate_origin_name, length: [max: 23], format: ~r/^[[:alnum:] ]+$/)
  validates(:file_creation_date, presence: true, length: 6, format: ~r/^[[:digit:]]+$/)
  validates(:file_creation_time, length: 4, format: ~r/^[[:digit:]]+$/)
  validates(:file_id_modifier, presence: true, format: ~r/^[[:alnum:]]+$/)
  validates(:reference_code, presence: true, format: ~r/^[[:alnum:]]+$/)

  @spec new(ExAch.file_header_params()) :: %__MODULE__{}
  def new(params) do
    %__MODULE__{
      immediate_destination: params.immediate_destination,
      immediate_destination_name: params[:immediate_destination_name],
      immediate_origin: params.immediate_origin,
      immediate_origin_name: params[:immediate_origin_name],
      file_creation_date: params.file_creation_date,
      file_creation_time: params[:file_creation_time],
      file_id_modifier: params.file_id_modifier,
      reference_code: params[:reference_code]
    }
  end
end

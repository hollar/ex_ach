defmodule ExAch.FileHeaderParams do

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

  def new(params) do
    %__MODULE__{
      immediate_destination: params[:immediate_destination],
      immediate_destination_name: params[:immediate_destination_name],
      immediate_origin: params[:immediate_origin],
      immediate_origin_name: params[:immediate_origin_name],
      file_creation_date: params[:file_creation_date],
      file_creation_time: params[:file_creation_time],
      file_id_modifier: params[:file_id_modifier],
      reference_code: params[:reference_code]
    }
  end
end

defmodule ExAch.Batch.Header.Fields.CompanyName do
  @moduledoc """
  Your company name, up to 16 characters. This name may appear on the receivers’ statements
  prepared by the Receiving Financial Institution.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field,
    specifications: [
      type: :alpha_num_string,
      max_length: 16
    ]
end

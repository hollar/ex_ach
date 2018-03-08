defmodule ExAch.File.Header.Fields.ImmediateOrigin do
  @moduledoc """
  Your 10-digit company number. The use of an IRS Federal Tax Identification Number as a company
  identification is recommended. Otherwise, ABN AMRO will create a unique number for your company.
  """

  @type t :: %__MODULE__{}
  use ExAch.Field, specifications: [type: :integer, length: 10]
end

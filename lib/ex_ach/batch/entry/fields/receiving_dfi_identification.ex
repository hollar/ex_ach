defmodule ExAch.Batch.Entry.Fields.ReceivingDfiIdentification do
  @moduledoc """
  Transit routing number of the receiver's financial institution.
  """

  use ExAch.Field, validation: [format: {~r/^\d{8}$/, "Must be 8 digits"}], render: :ttttaaaa
end

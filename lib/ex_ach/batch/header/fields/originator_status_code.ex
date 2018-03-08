defmodule ExAch.Batch.Header.Fields.OriginatorStatusCode do
  @moduledoc """
  Enter "1". This identifies LaSalle/Standard Federal as a depository financial institution,
  which is bound by the rules of the ACH.
  """
  use ExAch.Field, default_content: 1
end

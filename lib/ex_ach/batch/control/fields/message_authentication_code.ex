defmodule ExAch.Batch.Control.Fields.MessageAuthenticationCode do
  @moduledoc """
  The MAC is an eight character code derived from a special key used in
  conjunction with the DES algorithm. The MAC is used to validate the
  authenticity of ACM Entries. The DES algorithm and key message standards
  must be in accordance with standards adopted by the American National
  Standards Institute. The remaining eleven characters of this field are blank.
  """

  use ExAch.Field, value: "", render: {:string, 19}
end

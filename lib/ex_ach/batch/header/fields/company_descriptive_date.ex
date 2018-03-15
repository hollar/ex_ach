defmodule ExAch.Batch.Header.Fields.CompanyDescriptiveDate do
  @moduledoc """
  Except as otherwise noted below, the Originator establishes this field as the date  it would like
  to see displayed to the Receiver for descriptive purposes. This field is never used to control
  timing of any computer or manual operation. It is solely for descriptive purposes. The RDFI should
  not assume any specific format. Examples of possible content in this field are "011311," "01 11,"
  "Jan 13," "JAN 11," etc.
  """

  use ExAch.Field, validation: [type: :alphameric], render: {:string, 6}
end

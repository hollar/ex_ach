defmodule ExAch.File.Header do
  alias ExAch.File.Header.Fields.{
    ImmediateDestination,
    ImmediateOrigin,
    FileCreationDate,
    FileIdModifier,
    RecordTypeCode,
    PriorityCode,
    BlockingFactor,
    RecordSize,
    FormatCode
  }

  defstruct [
    :immediate_destination,
    :immediate_origin,
    :file_creation_date,
    :reference_code,
    :file_id_modifier,

    :record_type_code,
    :priority_code,
    :record_size,
    :blocking_factor,
    :format_code,

    :file_creation_time,
    :immediate_destination_name,
    :immediate_origin_name
  ]

  def new(
    %ImmediateDestination{} = immediate_destination,
    %ImmediateOrigin{} = immediate_origin,
    %FileCreationDate{} = file_creation_date,
    %FileIdModifier{} = file_id_modifier,
    opts \\ []
  ) do

    header = %__MODULE__{
      immediate_destination: immediate_destination,
      immediate_origin: immediate_origin,
      file_creation_date: file_creation_date,
      file_id_modifier: file_id_modifier,
      record_type_code: RecordTypeCode.new(),
      priority_code: PriorityCode.new(),
      file_creation_time: Keyword.get(opts, :file_creation_time),
      record_size: RecordSize.new(),
      blocking_factor: BlockingFactor.new(),
      format_code: FormatCode.new(),
      immediate_destination_name: Keyword.get(opts, :immediate_destination_name),
      reference_code: Keyword.get(opts, :reference_code),
      immediate_origin_name: Keyword.get(opts, :immediate_origin_name)
    }
    {:ok, header}
  end
end
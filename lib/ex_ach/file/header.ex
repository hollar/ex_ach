defmodule ExAch.File.Header do
  use ExAch.Record

  alias ExAch.File.Header.Fields.{
    BlockingFactor,
    FileCreationDate,
    FileCreationTime,
    FileIdModifier,
    FormatCode,
    ImmediateDestination,
    ImmediateDestinationName,
    ImmediateOrigin,
    ImmediateOriginName,
    PriorityCode,
    RecordSize,
    RecordTypeCode,
    ReferenceCode
  }

  alias ExAch.Field

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

  @type t :: %__MODULE__{
          blocking_factor: BlockingFactor.t(),
          file_creation_date: FileCreationDate.t(),
          file_creation_time: FileCreationTime.t() | Field.Optional.t(),
          file_id_modifier: FileIdModifier.t(),
          format_code: FormatCode.t(),
          immediate_destination: ImmediateDestination.t(),
          immediate_destination_name: ImmediateDestinationName.t() | Field.Optional.t(),
          immediate_origin: ImmediateOrigin.t(),
          immediate_origin_name: ImmediateOriginName.t() | Field.Optional.t(),
          priority_code: PriorityCode.t(),
          record_size: RecordSize.t(),
          record_type_code: RecordTypeCode.t(),
          reference_code: ReferenceCode.t() | Field.Optional.t()
        }

  @doc """
  Creates a new File Header Structure.

  ## Options
    * `:immediate_destination_name`
    * `:reference_code`
    * `:immediate_origin_name`
  """
  @spec new(ImmediateDestination.t(), ImmediateOrigin.t(), FileIdModifier.t(), Keyword.t()) ::
          {:ok, t}
  def new(
        %ImmediateDestination{} = immediate_destination,
        %ImmediateOrigin{} = immediate_origin,
        %FileIdModifier{} = file_id_modifier,
        opts \\ []
      ) do
    file_creation_date = Keyword.get(opts, :file_creation_date, FileCreationDate.new())

    header = %__MODULE__{
      record_type_code: RecordTypeCode.new(),
      priority_code: PriorityCode.new(),
      immediate_destination: immediate_destination,
      immediate_origin: immediate_origin,
      file_creation_date: file_creation_date,
      file_creation_time: assign_optional(opts, FileCreationTime),
      file_id_modifier: file_id_modifier,
      record_size: RecordSize.new(),
      blocking_factor: BlockingFactor.new(),
      format_code: FormatCode.new(),
      immediate_destination_name: assign_optional(opts, ImmediateDestinationName),
      immediate_origin_name: assign_optional(opts, ImmediateOriginName),
      reference_code: assign_optional(opts, ReferenceCode)
    }

    {:ok, header}
  end

  @spec to_iodata(t()) :: iodata()
  def to_iodata(header) do
    [
      header.record_type_code,
      header.priority_code,
      header.immediate_destination,
      header.immediate_origin,
      header.file_creation_date,
      header.file_creation_time,
      header.file_id_modifier,
      header.record_size,
      header.blocking_factor,
      header.format_code,
      header.immediate_destination_name,
      header.immediate_origin_name,
      header.reference_code
    ]
    |> Enum.map(&to_string/1)
  end
end

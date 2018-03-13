defmodule ExAch.File.Header do
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
          file_creation_time: FileCreationTime.t(),
          file_id_modifier: FileIdModifier.t(),
          format_code: FormatCode.t(),
          immediate_destination: ImmediateDestination.t(),
          immediate_destination_name: ImmediateDestinationName.t() | nil,
          immediate_origin: ImmediateOrigin.t(),
          immediate_origin_name: ImmediateOriginName.t() | nil,
          priority_code: PriorityCode.t(),
          record_size: RecordSize.t(),
          record_type_code: RecordTypeCode.t(),
          reference_code: ReferenceCode.t() | nil
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
    header = %__MODULE__{
      immediate_destination: immediate_destination,
      immediate_origin: immediate_origin,
      file_creation_date: FileCreationDate.new(),
      file_id_modifier: file_id_modifier,
      record_type_code: RecordTypeCode.new(),
      priority_code: PriorityCode.new(),
      file_creation_time: FileCreationTime.new(),
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

defmodule ExAch.File.HeaderTest do
  use ExUnit.Case

  alias ExAch.File.Header

  alias ExAch.File.Header.Fields.{
    ImmediateDestination,
    ImmediateOrigin,
    ReferenceCode,
    FileIdModifier,
    FileCreationDate,
    FileCreationTime,
    ImmediateDestinationName,
    ImmediateOriginName
  }

  alias ExAch.Field

  describe "creating file header" do
    test "file header created successfully" do
      {:ok, immediate_destination} = ImmediateDestination.new("171000505")
      {:ok, immediate_origin} = ImmediateOrigin.new("123456789")
      {:ok, reference_code} = ReferenceCode.new("refcode")
      {:ok, file_id_modifier} = FileIdModifier.new("1")
      {:ok, immediate_destination_name} = ImmediateDestinationName.new("LaSalle Bank")
      {:ok, immediate_origin_name} = ImmediateOriginName.new("Hollar Inc")
      {:ok, file_creation_date} = FileCreationDate.new(~D[2001-01-01])
      {:ok, file_creation_time} = FileCreationTime.new(~T[23:24:00])

      {:ok, file_header} =
        Header.new(
          immediate_destination,
          immediate_origin,
          file_id_modifier,
          immediate_destination_name: immediate_destination_name,
          immediate_origin_name: immediate_origin_name,
          reference_code: reference_code,
          file_creation_date: file_creation_date,
          file_creation_time: file_creation_time
        )

      # Mandatory fields required to be passed by user
      assert file_header.immediate_destination == immediate_destination
      assert file_header.immediate_origin == immediate_origin
      assert file_header.file_creation_date
      assert file_header.file_id_modifier == file_id_modifier

      # Mandatory fields generated by library
      assert Field.value(file_header.record_type_code) == "1"
      assert Field.value(file_header.priority_code) == "01"
      assert Field.value(file_header.record_size) == 94
      assert Field.value(file_header.blocking_factor) == 10
      assert Field.value(file_header.format_code) == 1
      assert Field.value(file_header.file_creation_date) == ~D[2001-01-01]
      assert Field.value(file_header.file_creation_time) == ~T[23:24:00]

      # Optional fields passed by user
      assert Field.value(file_header.immediate_destination_name) == "LaSalle Bank"
      assert Field.value(file_header.immediate_origin_name) == "Hollar Inc"
      assert file_header.reference_code == reference_code
    end

    test "optional fields get assigned a value" do
      {:ok, immediate_destination} = ImmediateDestination.new("171000505")
      {:ok, immediate_origin} = ImmediateOrigin.new("123456789")
      {:ok, file_id_modifier} = FileIdModifier.new("1")

      {:ok, file_header} =
        Header.new(
          immediate_destination,
          immediate_origin,
          file_id_modifier
        )

      assert Field.module(file_header.immediate_destination_name) == Field.Optional
      assert Field.module(file_header.immediate_origin_name) == Field.Optional
      assert Field.module(file_header.reference_code) == Field.Optional
      assert Field.module(file_header.file_creation_time) == Field.Optional
    end
  end
end

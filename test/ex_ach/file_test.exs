defmodule ExAch.FileTest do
  use ExUnit.Case

  alias ExAch.File

  describe "creating an ach file" do
    test "creates file with header" do
      {:ok, immediate_destination} = File.Header.Fields.ImmediateDestination.new("b071000505")
      {:ok, immediate_origin} = File.Header.Fields.ImmediateOrigin.new("b071000505")
      {:ok, creation_date} = File.Header.Fields.FileCreationDate.new(~D[2000-01-01])
      {:ok, file_id_modifier} = File.Header.Fields.FileIdModifier.new("1")
      {:ok, header} = File.Header.new(
              immediate_destination,
              immediate_origin,
              creation_date,
              file_id_modifier
            )
      batches = []

      {:ok, ach} = ExAch.File.new(header, batches)

      assert ach.header == header
      assert ach.batches == batches
    end
  end
end

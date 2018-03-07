defmodule ExAch.Batch.HeaderValidationTest do
  use ExAch.TestCase

  alias ExAch.Batch.Header.Fields.{
    ServiceClassCode,
    CompanyName,
    CompanyIdentification,
    StandardEntryClassCode,
    CompanyEntryDescription,
    EffectiveEntryDate,
    BatchNumber
  }

  describe "validating service_class_code" do
    test "a valid value returns successfully" do
      assert {:ok, %ServiceClassCode{content: 220}} = ServiceClassCode.new(220)
    end

    test "an invalid value returns an error" do
      assert {:error, [{:service_class_code, :non_permitted, "Must be 220, 200 or 225"}]} =
               ServiceClassCode.new(345)
    end
  end

  describe "validating company_name" do
    test "an invalid value returns an error" do
      assert {:error, [{:company_name, :max_length, "Must be less than 16 character"}]} =
               CompanyName.new("company name too long")
    end

    test "an non alphanum character returns an error" do
      assert {:error, [{:company_name, :format, "Must be alphanum"}]} =
               CompanyName.new("company_name")
    end

    test "two errors get accumulated" do
      {:error, errors} = CompanyName.new("company_name too long")

      assert {:company_name, :format, "Must be alphanum"} in errors
      assert {:company_name, :max_length, "Must be less than 16 character"} in errors
    end

    test "valid value returns successfully" do
      {:ok, %CompanyName{content: "CompanyName"}} = CompanyName.new("CompanyName")
    end
  end

  describe "validating company_identification" do
    test "an invalid value returns an error" do
      assert {:error, [{:company_identification, :length, "Must be 10 digits"}]} =
               CompanyIdentification.new(12_345_678_900)
    end

    test "valid value returns successfully" do
      {:ok, %CompanyIdentification{content: 1_112_223_334}} =
        CompanyIdentification.new(1_112_223_334)
    end
  end

  describe "validating standard_entry_class" do
    test "an invalid value returns an error" do
      assert {:error,
              [{:standard_entry_class_code, :inclusion, "Must be in [web,ccd,ppd,ctx,tel,web]"}]} =
               StandardEntryClassCode.new(:code)
    end

    test "valid value returns successfully" do
      {:ok, %StandardEntryClassCode{content: :web}} = StandardEntryClassCode.new(:web)
    end
  end

  describe "validating company_entry_description" do
    test "an invalid value returns an error" do
      assert {:error,
              [{:company_entry_description, :max_length, "Must be less than 10 character"}]} =
               CompanyEntryDescription.new("long description")
    end

    test "valid value returns successfully" do
      {:ok, %CompanyEntryDescription{content: "desc"}} = CompanyEntryDescription.new("desc")
    end
  end

  describe "validating effective_entry_date" do
    test "an invalid value returns an error" do
      assert {:error, [{:effective_entry_date, :format, "Must be a date"}]} =
               EffectiveEntryDate.new("string")
    end

    test "valid value returns successfully" do
      {:ok, %EffectiveEntryDate{content: ~D[2000-01-01]}} = EffectiveEntryDate.new(~D[2000-01-01])
    end
  end

  describe "validating  batch_number" do
    test "an invalid value returns an error" do
      assert {:error, [{:batch_number, :max_length, "Must be less than 7 digits"}]} =
               BatchNumber.new(12_345_678)
    end

    test "valid value returns successfully" do
      {:ok, %BatchNumber{content: 1}} = BatchNumber.new(1)
    end
  end
end

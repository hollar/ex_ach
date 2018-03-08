defmodule ExAch.Batch.HeaderValidationTest do
  use ExAch.TestCase

  alias ExAch.Batch.Header.Fields.{
    ServiceClassCode,
    CompanyName,
    CompanyIdentification,
    StandardEntryClassCode,
    CompanyEntryDescription,
    EffectiveEntryDate,
    BatchNumber,
    OriginatingDfiIdentification
  }

  describe "validating service_class_code" do
    test "a valid value returns successfully" do
      assert {:ok, %ServiceClassCode{content: 220}} = ServiceClassCode.new(220)
    end

    test "an invalid value returns an error" do
      assert {:error, [{:service_class_code, :inclusion, "Must be in [200,220,225]"}]} =
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

    test "an invalid type returns an error" do
      assert {:error, [{:company_identification, :type, "Must be an integer"}]} =
        CompanyIdentification.new("1234567890")
    end

    test "valid value returns successfully" do
      {:ok, %CompanyIdentification{content: 1_112_223_334}} =
        CompanyIdentification.new(1_112_223_334)
    end
  end

  describe "validating standard_entry_class" do
    test "an invalid value returns an error" do
      {:error, errors} = StandardEntryClassCode.new(:code)
      assert {:standard_entry_class_code, :inclusion, "Must be in [web,ccd,ppd,ctx,tel]"} in errors
    end

    test "an invalid type returns an error" do
      expected_error = {:standard_entry_class_code, :type, "Must be an atom"}
      {:error, errors} = StandardEntryClassCode.new("code")
      assert expected_error in errors
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

    test "an invalid type returns an error" do
      assert {:error,
              [{:company_entry_description, :type, "Must be an alphanum string"}]} =
        CompanyEntryDescription.new(122)
    end

    test "valid value returns successfully" do
      {:ok, %CompanyEntryDescription{content: "desc"}} = CompanyEntryDescription.new("desc")
    end
  end

  describe "validating effective_entry_date" do
    test "an invalid value returns an error" do
      assert {:error, [{:effective_entry_date, :type, "Must be a date"}]} =
               EffectiveEntryDate.new("string")
    end

    test "valid value returns successfully" do
      {:ok, %EffectiveEntryDate{content: ~D[2000-01-01]}} = EffectiveEntryDate.new(~D[2000-01-01])
    end
  end

  describe "validating originating_dfi_identification" do
    test "an invalid type returns an error" do
      expected_error = {:originating_dfi_identification, :type, "Must be an integer"}
      {:error, errors} = OriginatingDfiIdentification.new("string")
      assert expected_error in errors
    end

    test "an invalid value returns an error" do
      assert {:error, [{:originating_dfi_identification, :max_length, "Must be less than 8 digits"}]} =
        OriginatingDfiIdentification.new(123456789)
    end

    test "valid value returns successfully" do
      {:ok, %OriginatingDfiIdentification{content: 7100050}} = OriginatingDfiIdentification.new(7100050)
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

    test "an invalid type returns an error" do
      assert {:error, [{:batch_number, :type, "Must be an integer"}]} =
        BatchNumber.new("1234567")
    end
  end
end

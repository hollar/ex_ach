defmodule ExAch.FieldValidatorTest do
  use ExUnit.Case
  alias ExAch.FieldValidator

  describe "validating string type" do
    test "non alpha numeric string type returns an error" do
      validation_rules = [{:field_name, :type, :alphameric}]
      errors = FieldValidator.validate(123, validation_rules)
      assert errors == [{:field_name, :type, "Must be an alphanum string"}]
    end

    test "type of alpha numeric string does not returns error" do
      validation_rules = [{:field_name, :type, :alphameric}]
      errors = FieldValidator.validate("string", validation_rules)
      assert Enum.empty?(errors)
    end
  end

  describe "validating atom type" do
    test "non-atom type returns an error" do
      validation_rules = [{:field_name, :type, :atom}]
      errors = FieldValidator.validate(123, validation_rules)
      assert errors == [{:field_name, :type, "Must be an atom"}]
    end

    test "type of atom returns does not return error" do
      validation_rules = [{:field_name, :type, :atom}]
      errors = FieldValidator.validate(:atom, validation_rules)
      assert Enum.empty?(errors)
    end
  end

  describe "validating integer type" do
    test "type of string returns an error" do
      validation_rules = [{:field_name, :type, :integer}]
      errors = FieldValidator.validate("123", validation_rules)
      assert errors == [{:field_name, :type, "Must be an integer"}]
    end

    test "type of integer does not return errors" do
      validation_rules = [{:field_name, :type, :integer}]
      errors = FieldValidator.validate(123, validation_rules)
      assert Enum.empty?(errors)
    end
  end

  describe "validating date type" do
    test "type of date returns an error" do
      validation_rules = [{:field_name, :type, :date}]
      errors = FieldValidator.validate("123", validation_rules)
      assert errors == [{:field_name, :type, "Must be a date"}]
    end

    test "type of date does not return errors" do
      validation_rules = [{:field_name, :type, :date}]
      errors = FieldValidator.validate(~D[2001-01-01], validation_rules)
      assert Enum.empty?(errors)
    end
  end

  describe "validating time type" do
    test "type of date returns an error" do
      validation_rules = [{:field_name, :type, :time}]
      errors = FieldValidator.validate("123", validation_rules)
      assert errors == [{:field_name, :type, "Must be a time"}]
    end

    test "type of time does not return errors" do
      validation_rules = [{:field_name, :type, :time}]
      errors = FieldValidator.validate(~T[23:00:00], validation_rules)
      assert Enum.empty?(errors)
    end
  end

  describe "validating max_length" do
    test "string too long returns an error" do
      validation_rules = [{:field_name, :max_length, 3}]
      errors = FieldValidator.validate("1234", validation_rules)

      assert errors == [
               {:field_name, :max_length, "Must be less than or equal to 3 character(s)"}
             ]
    end

    test "integer too long returns an error" do
      validation_rules = [{:field_name, :max_length, 3}]
      errors = FieldValidator.validate(1234, validation_rules)
      assert errors == [{:field_name, :max_length, "Must be less than or equal to 3 digit(s)"}]
    end

    test "valid string does not return errors" do
      validation_rules = [{:field_name, :max_length, 1}]
      errors = FieldValidator.validate("a", validation_rules)
      assert Enum.empty?(errors)
    end

    test "valid integer does not return errors" do
      validation_rules = [{:field_name, :max_length, 1}]
      errors = FieldValidator.validate(1, validation_rules)
      assert Enum.empty?(errors)
    end
  end

  describe "validating length" do
    test "string too long returns an error" do
      validation_rules = [{:field_name, :length, 3}]
      errors = FieldValidator.validate("1234", validation_rules)
      assert errors == [{:field_name, :length, "Must be 3 character(s)"}]
    end

    test "integer too long returns an error" do
      validation_rules = [{:field_name, :length, 3}]
      errors = FieldValidator.validate(1234, validation_rules)
      assert errors == [{:field_name, :length, "Must be 3 digit(s)"}]
    end

    test "string too short returns an error" do
      validation_rules = [{:field_name, :length, 3}]
      errors = FieldValidator.validate("12", validation_rules)
      assert errors == [{:field_name, :length, "Must be 3 character(s)"}]
    end

    test "integer too short returns an error" do
      validation_rules = [{:field_name, :length, 3}]
      errors = FieldValidator.validate(12, validation_rules)
      assert errors == [{:field_name, :length, "Must be 3 digit(s)"}]
    end

    test "valid string does not return errors" do
      validation_rules = [{:field_name, :length, 1}]
      errors = FieldValidator.validate("a", validation_rules)
      assert Enum.empty?(errors)
    end

    test "valid integer does not return errors" do
      validation_rules = [{:field_name, :length, 1}]
      errors = FieldValidator.validate(1, validation_rules)
      assert Enum.empty?(errors)
    end
  end

  describe "validating inclusion" do
    test "not allowed values returns an error" do
      validation_rules = [{:field_name, :inclusion, [1, 2]}]
      errors = FieldValidator.validate(3, validation_rules)
      assert errors == [{:field_name, :inclusion, "Must be in [1,2]"}]
    end

    test "allowed value does not return errors" do
      validation_rules = [{:field_name, :inclusion, [1, 2]}]
      errors = FieldValidator.validate(1, validation_rules)
      assert Enum.empty?(errors)
    end
  end

  describe "validating format" do
    test "matching format does not returns error" do
      validation_rules = [{:field_name, :format, ~r/^[0-9A-Z]$/}]
      errors = FieldValidator.validate("A", validation_rules)
      assert Enum.empty?(errors)
    end

    test "non-matching format returns error" do
      validation_rules = [{:field_name, :format, ~r/^[0-9A-Z]$/}]
      errors = FieldValidator.validate("s 9", validation_rules)
      assert errors == [{:field_name, :format, "Wrong format"}]
    end

    test "non string returns string type error" do
      validation_rules = [{:field_name, :format, ~r/^[0-9A-Z]$/}]
      errors = FieldValidator.validate(9, validation_rules)
      assert errors == [{:field_name, :type, "Must be an alphanum string"}]
    end

    test "non-matching format returns given error message" do
      validation_rules = [{:field_name, :format, {~r/^[A-Z]$/, ":message:"}}]
      errors = FieldValidator.validate("9", validation_rules)
      assert errors == [{:field_name, :format, ":message:"}]
    end
  end
end

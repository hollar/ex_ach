defmodule ExAch do
  @moduledoc ~S"""

        iex> alias ExAch.{File, Batch}
        ...> {:ok, immediate_destination} = File.Header.Fields.ImmediateDestination.new(071000505)
        ...> {:ok, immediate_origin} = File.Header.Fields.ImmediateOrigin.new(071000505)
        ...> {:ok, reference_code} = File.Header.Fields.ReferenceCode.new("refcode")
        ...> {:ok, file_id_modifier} = File.Header.Fields.FileIdModifier.new("1")
        ...> {:ok, immediate_origin_name} = File.Header.Fields.ImmediateOriginName.new("RBC ROYAL Bank")
        ...> {:ok, immediate_destination_name} = File.Header.Fields.ImmediateDestinationName.new("RBC ROYAL Bank")
        ...> {:ok, file_header} = ExAch.File.Header.new(
        ...>   immediate_destination,
        ...>   immediate_origin,
        ...>   file_id_modifier,
        ...>   immediate_destination_name: immediate_destination_name,
        ...>   immediate_origin_name: immediate_origin_name,
        ...>   reference_code: reference_code
        ...> )
        ...> # Creating a batch header
        ...> {:ok, service_class_code} = Batch.Header.Fields.ServiceClassCode.new(220)
        ...> {:ok, company_name} = Batch.Header.Fields.CompanyName.new("CompanyName")
        ...> {:ok, company_identification} = Batch.Header.Fields.CompanyIdentification.new(1112223334)
        ...> {:ok, standard_entry_class_code} = Batch.Header.Fields.StandardEntryClassCode.new(:ccd)
        ...> {:ok, company_entry_description} = Batch.Header.Fields.CompanyEntryDescription.new("DESC1")
        ...> {:ok, effective_entry_date} =  Batch.Header.Fields.EffectiveEntryDate.new(~D[2000-01-01])
        ...> {:ok, batch_number} = Batch.Header.Fields.BatchNumber.new(1)
        ...> {:ok, originating_dfi_identification} = Batch.Header.Fields.OriginatingDfiIdentification.new(12345678)
        ...> {:ok, company_descriptive_date} = Batch.Header.Fields.CompanyDescriptiveDate.new(~D[2000-01-01])
        ...> {:ok, company_discretionary_data} = Batch.Header.Fields.CompanyDiscretionaryData.new("Data1")
        ...> {:ok, batch_header} =
        ...> ExAch.Batch.Header.new(
        ...>   service_class_code,
        ...>   company_name,
        ...>   company_identification,
        ...>   standard_entry_class_code,
        ...>   company_entry_description,
        ...>   effective_entry_date,
        ...>   batch_number,
        ...>   originating_dfi_identification,
        ...>   company_descriptive_date: company_descriptive_date,
        ...>   company_discretionary_data: company_discretionary_data
        ...> )
        ...> # Creating a batch entry
        ...> {:ok, transaction_code} = Batch.Entry.Fields.TransactionCode.new(22)
        ...> {:ok, receiving_dfi_identification} = Batch.Entry.Fields.ReceivingDfiIdentification.new("12345678")
        ...> {:ok, check_digit} = Batch.Entry.Fields.CheckDigit.new(1)
        ...> {:ok, dfi_account_number} = Batch.Entry.Fields.DfiAccountNumber.new("53342")
        ...> {:ok, amount} = Batch.Entry.Fields.Amount.new(1000)
        ...> {:ok, receiving_company_name} = Batch.Entry.Fields.ReceivingCompanyName.new("receiving company")
        ...> {:ok, addenda_record_indicator} = Batch.Entry.Fields.AddendaRecordIndicator.new(0)
        ...> {:ok, trace_number} = Batch.Entry.Fields.TraceNumber.new(1)
        ...> {:ok, discretionary_data} = Batch.Entry.Fields.DiscretionaryData.new("A1")
        ...> {:ok, identification_number} = Batch.Entry.Fields.IdentificationNumber.new("7777")
        ...> {:ok, batch_entry} =
        ...>   ExAch.Batch.Entry.new(
        ...>     transaction_code,
        ...>     receiving_dfi_identification,
        ...>     check_digit,
        ...>     dfi_account_number,
        ...>     amount,
        ...>     receiving_company_name,
        ...>     addenda_record_indicator,
        ...>     trace_number,
        ...>     discretionary_data: discretionary_data,
        ...>     identification_number: identification_number
        ...>   )
        ...> entries = [batch_entry]
        ...> # Create a batch
        ...> {:ok, batch} = ExAch.Batch.new(batch_header, entries)
        ...> # Create new ach file struct:
        ...> {:ok, ach} = ExAch.File.new(file_header, [batch])
        ...> ExAch.File.to_string(ach) |> String.split("\n")
        ["101 071000505 0235005121803121611A094101IMM ROYAL BANK         BMO BANK                       ",
         "5220COMPANYNAME     DATA1               1112223334CCDDESC1     000101000101   1123456780000001",
         "62212345678153342            00000010007777           RECEIVING COMPANY     A10000000000000001",
         "822000000100123456780000000000000000000010001112223334                         123456780000001",
         "9000001000001000000010012345678000000000000000000001000                                       ",
         "9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999",
         "9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999",
         "9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999",
         "9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999",
         "9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999",
         ""]
  """
end

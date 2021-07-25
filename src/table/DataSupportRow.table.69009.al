table 69009 "Data Support Row"
{
    DataClassification = CustomerContent;
    TableType = Temporary;
    fields
    {
        field(1; RecId; RecordId)
        {
            DataClassification = CustomerContent;

        }
        field(2; TableNo; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; FieldValue1; Text[100])
        {
            DataClassification = CustomerContent;
            CaptionClass = GetFieldName(FieldNo1);
            trigger OnValidate()
            begin
                UpdateFieldValue(FieldNo1, FieldValue1);
            end;

            trigger OnLookup()
            begin
                LookupField(FieldNo1);
            end;
        }
        field(4; FieldValue2; Text[100])
        {
            DataClassification = CustomerContent;
            CaptionClass = GetFieldName(FieldNo2);
            trigger OnValidate()
            begin
                UpdateFieldValue(FieldNo2, FieldValue2);
            end;

            trigger OnLookup()
            begin
                LookupField(FieldNo2);
            end;

        }
        field(5; FieldValue3; Text[100])
        {
            DataClassification = CustomerContent;
            CaptionClass = GetFieldName(FieldNo3);
            trigger OnValidate()
            begin
                UpdateFieldValue(FieldNo3, FieldValue3);
            end;

            trigger OnLookup()
            begin
                LookupField(FieldNo3);
            end;
        }
        field(6; FieldValue4; Text[100])
        {
            DataClassification = CustomerContent;
            CaptionClass = GetFieldName(FieldNo4);
            trigger OnValidate()
            begin
                UpdateFieldValue(FieldNo4, FieldValue4);
            end;

            trigger OnLookup()
            begin
                LookupField(FieldNo4);
            end;
        }
        field(7; FieldValue5; Text[100])
        {
            DataClassification = CustomerContent;
            CaptionClass = GetFieldName(FieldNo5);
            trigger OnValidate()
            begin
                UpdateFieldValue(FieldNo5, FieldValue5);
            end;

            trigger OnLookup()
            begin
                LookupField(FieldNo5);
            end;
        }
        field(8; FieldValue6; Text[100])
        {
            DataClassification = CustomerContent;
            CaptionClass = GetFieldName(FieldNo6);
            trigger OnValidate()
            begin
                UpdateFieldValue(FieldNo6, FieldValue6);
            end;

            trigger OnLookup()
            begin
                LookupField(FieldNo6);
            end;
        }
        field(9; FieldValue7; Text[100])
        {
            DataClassification = CustomerContent;
            CaptionClass = GetFieldName(FieldNo7);
            trigger OnValidate()
            begin
                UpdateFieldValue(FieldNo7, FieldValue7);
            end;

            trigger OnLookup()
            begin
                LookupField(FieldNo7);
            end;
        }
        field(21; FieldNo1; Integer)
        {
            DataClassification = CustomerContent;

        }
        field(22; FieldNo2; Integer)
        {
            DataClassification = CustomerContent;

        }
        field(23; FieldNo3; Integer)
        {
            DataClassification = CustomerContent;

        }
        field(24; FieldNo4; Integer)
        {
            DataClassification = CustomerContent;

        }
        field(25; FieldNo5; Integer)
        {
            DataClassification = CustomerContent;

        }
        field(26; FieldNo6; Integer)
        {
            DataClassification = CustomerContent;

        }
        field(27; FieldNo7; Integer)
        {
            DataClassification = CustomerContent;

        }

    }

    keys
    {
        key(Key1; RecId)
        {
            Clustered = true;
        }
    }
    procedure GetRecIdText(): Text
    begin
        exit(StrSubstNo('%1', RecId));
    end;

    procedure GetFieldName(CaptionFieldNo: Integer): Text[30]
    var
        FieldRef: FieldRef;
        Recordref: RecordRef;
    begin
        Recordref.Open(TableNo);
        if CaptionFieldNo = 0 then
            exit;
        FieldRef := Recordref.Field(CaptionFieldNo);
        exit(FieldRef.Caption);
    end;

    procedure SetDataSupportFilter(var NewTempDataSupportFilter: Record "Data Support Filter" temporary)
    begin
        TempDataSupportFilter.Reset();
        TempDataSupportFilter.DeleteAll();
        TempDataSupportFilter.Copy(NewTempDataSupportFilter, true);
    end;

    procedure FillFieldValues()
    var
        TempDataSupportField: Record "Data Support Field" temporary;
        i: Integer;
    begin
        if not TempDataSupportFilter.FindSet() then
            exit;
        TempDataSupportField.FillFieldsFromRow(RecId);
        repeat
            if TempDataSupportField.Get(RecId, TempDataSupportFilter."Filter Field No.") then begin
                i := i + 1;
                case i of
                    1:
                        begin
                            FieldValue1 := TempDataSupportField.FieldValue;
                            FieldNo1 := TempDataSupportField.FieldNo;
                        end;

                    2:
                        begin
                            FieldValue2 := TempDataSupportField.FieldValue;
                            FieldNo2 := TempDataSupportField.FieldNo;
                        end;
                    3:
                        begin
                            FieldValue3 := TempDataSupportField.FieldValue;
                            FieldNo3 := TempDataSupportField.FieldNo;
                        end;

                    4:
                        begin
                            FieldValue4 := TempDataSupportField.FieldValue;
                            FieldNo4 := TempDataSupportField.FieldNo;
                        end;

                    5:
                        begin
                            FieldValue5 := TempDataSupportField.FieldValue;
                            FieldNo5 := TempDataSupportField.FieldNo;
                        end;

                    6:
                        begin
                            FieldValue6 := TempDataSupportField.FieldValue;
                            FieldNo6 := TempDataSupportField.FieldNo;
                        end;

                    7:
                        begin
                            FieldValue7 := TempDataSupportField.FieldValue;
                            FieldNo7 := TempDataSupportField.FieldNo;
                        end;

                end
            end;
        until TempDataSupportFilter.next = 0;
    end;

    local procedure UpdateFieldValue(PosFieldNo: Integer; PosFieldValue: text)
    var
        TempDataSupportField: Record "Data Support Field" temporary;
    begin
        TempDataSupportField.FillFieldsFromRow(RecId);
        TempDataSupportField.get(RecId, PosFieldNo);
        TempDataSupportField.Validate(FieldValue, PosFieldValue);
        RefreshValues(TempDataSupportField, FieldNo1, FieldValue1);
        RefreshValues(TempDataSupportField, FieldNo2, FieldValue2);
        RefreshValues(TempDataSupportField, FieldNo3, FieldValue3);
        RefreshValues(TempDataSupportField, FieldNo4, FieldValue4);
        RefreshValues(TempDataSupportField, FieldNo5, FieldValue5);
        RefreshValues(TempDataSupportField, FieldNo6, FieldValue6);
        RefreshValues(TempDataSupportField, FieldNo7, FieldValue7);
    end;

    local procedure RefreshValues(var TempDataSupportField: Record "Data Support Field" temporary; OtherFieldNo: Integer; var OtherFiedlValue: Text)
    var
    begin
        if TempDataSupportField.Get(RecId, OtherFieldNo) then
            OtherFiedlValue := TempDataSupportField.FieldValue;
    end;

    local procedure LookupField(FieldNumber: Integer)
    var
        TempDataSupportField: record "Data Support Field" temporary;
    begin
        TempDataSupportField.RecId := RecId;
        TempDataSupportField.FieldNo := FieldNumber;
        TempDataSupportField.LookupTableRelationAndOptions();
    end;

    var
        TempDataSupportFilter: Record "Data Support Filter" temporary;
}
table 69009 "Data Support Row"
//Modo focus
//Error cambiar la clave del registro???
//Tratar Option
//Buffer de filas
//FormatExpr
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
            CaptionClass = GetFieldName(1);
        }
        field(4; FieldValue2; Text[100])
        {
            DataClassification = CustomerContent;
            CaptionClass = GetFieldName(2);
        }
        field(5; FieldValue3; Text[100])
        {
            DataClassification = CustomerContent;
            CaptionClass = GetFieldName(3);
        }
        field(6; FieldValue4; Text[100])
        {
            DataClassification = CustomerContent;
            CaptionClass = GetFieldName(4);
        }
        field(7; FieldValue5; Text[100])
        {
            DataClassification = CustomerContent;
            CaptionClass = GetFieldName(5);
        }
        field(8; FieldValue6; Text[100])
        {
            DataClassification = CustomerContent;
            CaptionClass = GetFieldName(6);
        }
        field(9; FieldValue7; Text[100])
        {
            DataClassification = CustomerContent;
            CaptionClass = GetFieldName(7);
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

    procedure GetFieldName(index: Integer): Text[30]
    var
        FieldRef: FieldRef;
        Recordref: RecordRef;
        CaptionFieldNo: Integer;
    begin
        Recordref.Open(TableNo);
        case index of
            1:
                CaptionFieldNo := FieldNo1;
            2:
                CaptionFieldNo := FieldNo2;
            3:
                CaptionFieldNo := FieldNo3;
            4:
                CaptionFieldNo := FieldNo4;
            5:
                CaptionFieldNo := FieldNo5;
            6:
                CaptionFieldNo := FieldNo6;
            7:
                CaptionFieldNo := FieldNo7;
        end;
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

    var
        TempDataSupportFilter: Record "Data Support Filter" temporary;
}
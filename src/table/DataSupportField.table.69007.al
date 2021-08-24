table 69007 "Data Support Field"
//Error cambiar la clave del registro???
//Tratar Option
//FormatExpr
//Borrado
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
        field(3; "Field No."; Integer)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Field: Record Field;
            begin
                if Field.Get(TableNo, "Field No.") then
                    Field.TestField(ObsoleteState, Field.ObsoleteState::No);
            end;
        }
        field(4; "Field Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(5; FieldValue; Text[250])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateRecord()
            end;

            trigger OnLookup()
            begin
                LookupTableRelationAndOptions();
            end;
        }

    }

    keys
    {
        key(Key1; RecId, "Field No.")
        {
            Clustered = true;
        }
    }
    procedure GetRecIdText(): Text
    begin
        exit(StrSubstNo('%1', RecId));
    end;

    procedure FillFieldsFromRow(NewRecId: RecordId)
    var
        SourceRecRef: RecordRef;
        i: Integer;
        FieldRef: FieldRef;
    begin
        RecId := NewRecId;
        if not SourceRecRef.Get(RecId) then
            exit;
        FOR i := 1 TO SourceRecRef.FIELDCOUNT DO BEGIN
            FieldRef := SourceRecRef.FIELDINDEX(i);
            TableNo := SourceRecRef.Number;
            if ProcessField(FieldRef) then begin
                "Field No." := FieldRef.Number;
                "Field Name" := FieldRef.Name;
                FieldValue := Format(FieldRef.Value);
                if not Insert() then
                    Modify();
            end;
        END;
        if FindFirst() then;
    end;

    local procedure ProcessField(var FieldRef: FieldRef): Boolean
    var
        Field: Record Field;
    begin
        if FieldRef.Class <> FieldRef.Class::Normal then
            exit(false);
        if not Field.Get(TableNo, FieldRef.Number) then
            exit(false);
        if Field.ObsoleteState <> Field.ObsoleteState::No then
            exit(false);
        Exit(FieldRef.Type in [FieldRef.Type::Boolean,
                             FieldRef.Type::Code,
                             FieldRef.Type::Date,
                             FieldRef.Type::DateFormula,
                             FieldRef.Type::DateTime,
                             FieldRef.Type::Decimal,
                             FieldRef.Type::Duration,
                             FieldRef.Type::Integer,
                             FieldRef.Type::Option,
                             FieldRef.Type::Text,
                             FieldRef.Type::Time]);
    end;

    local procedure UpdateRecord()
    var
        RowRecordRef: RecordRef;
        FieldRef: FieldRef;
        PrevRec: Record "Data Support Field";
    begin
        PrevRec := rec;
        RowRecordRef.get(RecId);
        FieldRef := RowRecordRef.Field("Field No.");
        SetValueToField(FieldRef);
        FieldRef.Validate();
        RowRecordRef.Modify();
        PrevRec := rec;
        FillFieldsFromRow(RecId);
        rec := PrevRec;
        if Find() then;
    end;

    local procedure SetValueToField(var FieldRef: FieldRef)
    var
        TestBoolean: Boolean;
        TestDate: Date;
        TestTime: Time;
        TestDateFormula: DateFormula;
        TestDateTime: DateTime;
        TestDuration: Duration;
        TestDecimal: Decimal;
    begin
        ClearLastError();
        Case FieldRef.Type of
            FieldRef.Type::Boolean:
                begin
                    Evaluate(TestBoolean, FieldValue);
                    FieldRef.Value := TestBoolean;
                end;
            FieldRef.Type::Code, FieldRef.Type::Text, FieldRef.Type::Integer:
                FieldRef.Value := FieldValue;
            FieldRef.Type::Date:
                begin
                    Evaluate(TestDate, FieldValue);
                    FieldRef.Value := TestDate;
                end;
            FieldRef.Type::DateFormula:
                begin
                    Evaluate(TestDateFormula, FieldValue);
                    FieldRef.Value := TestDateFormula;
                end;
            FieldRef.Type::DateTime:
                begin
                    Evaluate(TestDateTime, FieldValue);
                    FieldRef.Value := TestDateTime;

                end;
            FieldRef.Type::Decimal:
                begin
                    Evaluate(TestDecimal, FieldValue);
                    FieldRef.Value := TestDecimal;

                end;
            FieldRef.Type::Duration:
                begin
                    Evaluate(TestDuration, FieldValue);
                    FieldRef.Value := TestDuration;
                end;
            FieldRef.Type::Option:
                begin
                    FieldRef.Value := GetIntegerOption(FieldRef);
                end;

            FieldRef.Type::Time:
                begin
                    Evaluate(TestTime, FieldValue);
                    FieldRef.Value := TestTime;
                end;
        end;
    end;

    procedure LookupTableRelationAndOptions()
    var
        RecordRef: RecordRef;
        FieldRef: FieldRef;

    begin
        if not RecordRef.Get(RecId) then
            RecordRef.Open(TableNo);
        FieldRef := RecordRef.Field("Field No.");
        if FieldRef.Type = FieldRef.Type::Option then begin
            LookupOptionValue(FieldRef);
            exit;
        end;
        if FieldRef.Relation = 0 then
            exit;
        Hyperlink(GetUrl(ClientType::Current, CompanyName, ObjectType::Table, FieldRef.Relation));
    end;

    local procedure GetIntegerOption(FieldRef: FieldRef): Integer
    var
        OptionList: List of [Text];
        i: Integer;
    begin
        OptionList := FieldRef.OptionCaption.Split(',');
        for i := 1 to OptionList.Count do begin
            if StrPos(OptionList.get(i), FieldValue) = 1 then begin
                FieldValue := OptionList.get(i);
                exit(i - 1);
            end;
        end;
    end;

    local procedure LookupOptionValue(FieldRef: FieldRef)
    var
        OptionList: List of [Text];
        OptionSelection: Integer;
    begin
        OptionSelection := StrMenu(FieldRef.OptionCaption);
        if OptionSelection = 0 then
            exit;
        OptionList := FieldRef.OptionCaption.Split(',');
        FieldValue := OptionList.get(OptionSelection);
        validate(FieldValue);
    end;
}
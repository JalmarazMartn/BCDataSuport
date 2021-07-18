table 69007 "Data Support Buffer"
//Modo focus
//Error cambiar la clave del registro???
//Tratar Option
//Buffer de filas
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
        field(3; FieldNo; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(4; FieldName; Text[30])
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
        }

    }

    keys
    {
        key(Key1; RecId, FieldNo)
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
            if ProcessField(FieldRef) then begin
                TableNo := SourceRecRef.Number;
                FieldNo := FieldRef.Number;
                FieldName := FieldRef.Name;
                FieldValue := Format(FieldRef.Value);
                if not Insert() then
                    Modify();
            end;
        END;
        if FindFirst() then;
    end;

    local procedure ProcessField(var FieldRef: FieldRef): Boolean
    begin
        if FieldRef.Class <> FieldRef.Class::Normal then
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
        PrevRec: Record "Data Support Buffer";
    begin
        PrevRec := rec;
        RowRecordRef.get(RecId);
        FieldRef := RowRecordRef.Field(FieldNo);
        if not SetValueToField(FieldRef) then begin
            Message(GetLastErrorText());
            FieldValue := PrevRec.FieldValue;
            exit;
        end;
        FieldRef.Validate();
        RowRecordRef.Modify();
        PrevRec := rec;
        FillFieldsFromRow(RecId);
        rec := PrevRec;
        if Find() then;
    end;

    [TryFunction]
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
                    error('To.Do');
                end;

            FieldRef.Type::Time:
                begin
                    Evaluate(TestTime, FieldValue);
                    FieldRef.Value := TestTime;
                end;
        end;
    end;
}
table 69007 "Data Support Buffer"
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

    procedure FillFieldsFromRow(DataSupportRow: Record "Data Support Buffer" temporary)
    var
        SourceRecRef: RecordRef;
        i: Integer;
        FieldRef: FieldRef;
    begin
        SourceRecRef.Get(DataSupportRow.RecId);
        FOR i := 1 TO SourceRecRef.FIELDCOUNT DO BEGIN
            FieldRef := SourceRecRef.FIELDINDEX(i);
            if ProcessField(FieldRef) then begin
                Rec := DataSupportRow;
                FieldNo := FieldRef.Number;
                FieldName := FieldRef.Name;
                FieldValue := Format(FieldRef.Value);
                Insert();
            end;
        END;

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
}
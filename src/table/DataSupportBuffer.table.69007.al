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
        field(3; FieldNo; Text[30])
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
}
table 69007 "Data Suport Buffer"
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
        key(Key1; RecId)
        {
            Clustered = true;
        }
    }
}
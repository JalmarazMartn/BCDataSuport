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
        field(3; FieldName1; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(4; FieldValue1; Text[100])
        {
            DataClassification = CustomerContent;
            CaptionClass = FieldName1;
        }

    }

    keys
    {
        key(Key1; RecId)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
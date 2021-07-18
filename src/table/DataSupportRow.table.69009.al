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

}
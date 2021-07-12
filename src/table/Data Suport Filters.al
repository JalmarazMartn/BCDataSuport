table 69008 "Data Suport Filter"
{
    DataClassification = CustomerContent;
    TableType = Temporary;
    fields
    {
        field(1; TableNo; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; FieldNo; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Field."No." where(TableNo = field(TableNo));
            trigger OnValidate()
            begin
                CalcFields(FieldName);
            end;
        }
        field(3; "Filter Value"; Text[500])
        {
            DataClassification = CustomerContent;
        }
        field(4; FieldName; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Field.FieldName where(TableNo = field(TableNo), "No." = Field(fieldno)));
            Editable = false;
        }
    }

    keys
    {
        key(Key1; FieldNo)
        {
            Clustered = true;
        }
    }
    procedure FilterRecordref(Var RecordRef: RecordRef)
    var
        FieldRef: FieldRef;
    begin
        FindSet();
        Clear(RecordRef);
        RecordRef.Open(TableNo);
        repeat
            FieldRef := RecordRef.Field(FieldNo);
            FieldRef.SetFilter("Filter Value");
        until next = 0;
    end;

}
table 69008 "Data Support Filter"
{
    DataClassification = CustomerContent;
    TableType = Temporary;
    fields
    {
        field(1; "Filter Table No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Filter Field No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Field."No." where(TableNo = field("Filter Table No."));
            trigger OnValidate()
            begin
                CalcFields(FieldName);
            end;
        }
        field(3; "Filter Value"; Text[500])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Recordref: RecordRef;
            begin
                Recordref.Open("Filter Table No.");
                FilterFieldRef(Recordref);
            end;
        }
        field(4; FieldName; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Field.FieldName where(TableNo = field("Filter Table No."), "No." = Field("Filter Field No.")));
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Filter Field No.")
        {
            Clustered = true;
        }
    }
    procedure FilterRecordref(Var RecordRef: RecordRef)
    begin
        FindSet();
        Clear(RecordRef);
        RecordRef.Open("Filter Table No.");
        repeat
            FilterFieldRef(RecordRef);
        until next = 0;
    end;

    procedure FilterFieldRef(var RecordRef: RecordRef)
    var
        FieldRef: FieldRef;
    begin
        FieldRef := RecordRef.Field("Filter Field No.");
        FieldRef.SetFilter("Filter Value");
    end;

}
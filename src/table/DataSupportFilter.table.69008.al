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

            trigger OnLookup()
            var
                TempDataSupportField: Record "Data Support Field" temporary;
            begin
                TempDataSupportField.TableNo := "Filter Table No.";
                TempDataSupportField."Field No." := "Filter Field No.";
                TempDataSupportField.LookupTableRelationAndOptions();
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
        key(Key1; "Filter Table No.", "Filter Field No.")
        {
            Clustered = true;
        }
    }
    procedure FilterRecordref(Var RecordRef: RecordRef)
    begin
        Clear(RecordRef);
        RecordRef.Open("Filter Table No.");
        if not FindSet() then
            exit;
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

    procedure FillDataSupportRows(var TempRowDataSupportBuffer: Record "Data Support Row" temporary)
    var
        RecordRef: RecordRef;
    begin
        FilterRecordref(RecordRef);
        if RecordRef.count > 100 then
            if not Confirm(ManyRowsQst, false, RecordRef.Count) then
                exit;
        if not RecordRef.FindSet() then
            Error(ThereAreNoRowsErr);
        TempRowDataSupportBuffer.SetDataSupportFilter(Rec);
        repeat
            TempRowDataSupportBuffer.RecId := RecordRef.RecordId;
            TempRowDataSupportBuffer.TableNo := RecordRef.Number;
            TempRowDataSupportBuffer.FillFieldValues();
            TempRowDataSupportBuffer.Insert();
        until RecordRef.Next() = 0;

    end;

    procedure SelectFieldsFromPage()
    var
        DataSupportSelectField: page "Data Support Select Field";
        SelectedField: Record Field;
    begin
        SelectedField.SetRange(TableNo, "Filter Table No.");
        Clear(DataSupportSelectField);
        DataSupportSelectField.LookupMode(true);
        DataSupportSelectField.SetTableView(SelectedField);
        if DataSupportSelectField.RunModal() <> Action::LookupOK then
            exit;
        DataSupportSelectField.SetSelectionFilter(SelectedField);
        SelectedField.FindSet();
        repeat
            "Filter Table No." := SelectedField.TableNo;
            Validate("Filter Field No.", SelectedField."No.");
            if Insert() then;
        until SelectedField.next = 0;
    end;

    var
        ManyRowsQst: Label 'You will open a page with %1 rows. Are you sure?';
        ThereAreNoRowsErr: Label 'There are no rows to show';
}
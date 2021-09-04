page 69027 "Data Support Select Field"
{
    PageType = List;
    SourceTable = Field;
    Editable = false;
    UsageCategory = Administration;
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(FieldName; Rec.FieldName)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(TableName; rec.TableName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    procedure GetSelection(var SelectedFields: Record Field)
    begin
        CurrPage.SetSelectionFilter(SelectedFields);
    end;
}
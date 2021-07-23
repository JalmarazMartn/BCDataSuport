page 69027 "Data Support Select Field"
{
    PageType = List;
    SourceTable = Field;
    Editable = false;
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
            }
        }
    }
    procedure GetSelection(var SelectedFields: Record Field)
    begin
        CurrPage.SetSelectionFilter(SelectedFields);
    end;
}
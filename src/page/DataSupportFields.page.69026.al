page 69026 "Data Support Fields"
{
    PageType = ListPart;
    SourceTable = "Data Support Buffer";
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(FieldName; rec.FieldName)
                {
                    ApplicationArea = All;
                }
                field(FieldValue; rec.FieldValue)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    Actions
    {
        area(Processing)
        {

        }
    }
    procedure SetDataRow(DataSupportRow: Record "Data Support Buffer" temporary)
    begin
        rec.Reset();
        rec.DeleteAll();
        rec.FillFieldsFromRow(DataSupportRow.RecId);
        CurrPage.Update();
    end;
}
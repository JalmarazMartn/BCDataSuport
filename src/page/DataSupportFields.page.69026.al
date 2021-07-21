page 69026 "Data Support Fields"
{
    PageType = List;
    SourceTable = "Data Support Field";
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
            group(Process)
            {
                action(Action)
                {
                    ApplicationArea = All;
                    Promoted = true;
                    Image = Payroll;
                    trigger OnAction()
                    begin
                        Message('Super');
                    end;
                }

            }
        }
    }
    procedure SetDataRow(NewRecId: RecordId)
    begin
        rec.Reset();
        rec.DeleteAll();
        rec.FillFieldsFromRow(NewRecId);
        CurrPage.Update();
    end;
}
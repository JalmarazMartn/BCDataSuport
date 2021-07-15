page 69025 "Data Support Rows"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Data Support Buffer";
    SourceTableTemporary = true;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(RecId; rec.GetRecIdText())
                {
                    ApplicationArea = All;

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    procedure LoadRows(var TempDataSupportFilter: Record "Data Support Filter" temporary)
    var
    begin
        rec.Reset();
        rec.DeleteAll();
        TempDataSupportFilter.FillDataSupportRows(Rec);
    end;
}
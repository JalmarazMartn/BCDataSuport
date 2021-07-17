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
            part(DataFields; "Data Support Fields")
            {
                ApplicationArea = All;
            }

            repeater(Rows)
            {
                Caption = 'Rows';
                field(RecId; rec.GetRecIdText())
                {
                    ApplicationArea = All;

                }
            }
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
    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.DataFields.Page.SetDataRow(rec);
    end;

    procedure LoadRows(var TempDataSupportFilter: Record "Data Support Filter" temporary)
    var
    begin
        rec.Reset();
        rec.DeleteAll();
        TempDataSupportFilter.FillDataSupportRows(Rec);
    end;
}
page 69025 "Data Support Rows"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Data Support Row";
    SourceTableTemporary = true;
    layout
    {
        area(Content)
        {
            part(DataFields; "Data Support Fields")
            {
                ApplicationArea = All;
                ShowFilter = true;
            }

            repeater(Rows)
            {
                Caption = 'Rows';
                ShowCaption = true;
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
        CurrPage.DataFields.Page.SetDataRow(rec.RecId);
    end;

    procedure LoadRows(var TempDataSupportFilter: Record "Data Support Filter" temporary)
    var
    begin
        rec.Reset();
        rec.DeleteAll();
        TempDataSupportFilter.FillDataSupportRows(Rec);
    end;
}
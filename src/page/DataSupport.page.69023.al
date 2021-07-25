page 69023 "Data Support"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    AdditionalSearchTerms = 'Be carefull!!,Modify all data without related page';
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Table No."; TableNo)
                {
                    ApplicationArea = All;
                    TableRelation = AllObjWithCaption."Object ID";
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                        CurrPage.FiltersSubf.Page.SetTableNo(TableNo);
                    end;
                }
                field("Table Name"; GetTableName())
                {
                    ApplicationArea = All;
                }
            }
            group(Filters)
            {
                part(FiltersSubf; "Data Support Filters")
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
            action(ViewRows)
            {
                ApplicationArea = All;
                Image = View;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    CurrPage.FiltersSubf.Page.OpenRowsPage();
                end;
            }
        }
    }
    local procedure GetTableName(): Text[50];
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        if AllObjWithCaption.get(AllObjWithCaption."Object Type"::Table, TableNo) then
            exit(AllObjWithCaption."Object Name");
    end;

    var
        TableNo: Integer;
}
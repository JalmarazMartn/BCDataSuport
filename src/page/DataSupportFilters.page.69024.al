page 69024 "Data Support Filters"
{
    PageType = ListPart;
    SourceTable = "Data Support Filter";
    SourceTableTemporary = true;
    PopulateAllFields = true;
    layout
    {
        area(Content)
        {
            repeater(Table)
            {
                field(FieldNo; rec."Filter Field No.")
                {
                    ApplicationArea = All;
                }
                field("Filter Value"; Rec."Filter Value")
                {
                    ApplicationArea = All;
                }
                field(FieldName; rec.FieldName)
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
            action(GetFields)
            {
                ApplicationArea = All;
                Image = SuggestField;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    rec.SelectFieldsFromPage();
                end;
            }
        }
    }

    trigger OnNewRecord(Bellowxrec: Boolean)
    begin
        rec."Filter Table No." := TableNo;
    end;

    procedure SetTableNo(NewTableNo: Integer)
    begin
        rec.Reset();
        rec.DeleteAll();
        rec."Filter Table No." := NewTableNo;
        TableNo := NewTableNo;
    end;

    procedure OpenRowsPage()
    var
        DataSupportRows: page "Data Support Rows";
    begin
        DataSupportRows.LoadRows(Rec);
        DataSupportRows.Run();
    end;

    var
        TableNo: Integer;
}
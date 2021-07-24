page 69025 "Data Support Rows"
{
    PageType = List;
    SourceTable = "Data Support Row";
    SourceTableTemporary = true;
    layout
    {
        area(Content)
        {
            repeater(Rows)
            {
                Caption = 'Rows';
                ShowCaption = true;
                field(RecId; rec.GetRecIdText())
                {
                    ApplicationArea = All;

                }
                field(FieldValue1; rec.FieldValue1)
                {
                    ApplicationArea = All;
                }
                field(FieldValue2; rec.FieldValue2)
                {
                    ApplicationArea = All;
                }
                field(FieldValue3; rec.FieldValue3)
                {
                    ApplicationArea = All;
                }
                field(FieldValue4; rec.FieldValue4)
                {
                    ApplicationArea = All;
                }
                field(FieldValue5; rec.FieldValue5)
                {
                    ApplicationArea = All;
                }
                field(FieldValue6; rec.FieldValue6)
                {
                    ApplicationArea = All;
                }
                field(FieldValue7; rec.FieldValue7)
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
            action(EditAllFields)
            {
                Image = EditAdjustments;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction();
                var
                    TempDataSupportField: Record "Data Support Field" temporary;
                begin
                    TempDataSupportField.FillFieldsFromRow(Rec.RecId);
                    Page.RunModal(page::"Data Support Fields", TempDataSupportField);
                    rec.FillFieldValues();
                    CurrPage.Update();
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
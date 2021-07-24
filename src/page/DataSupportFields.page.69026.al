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
}
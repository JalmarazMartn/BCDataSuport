page 69026 "Data Support Fields"
{
    PageType = ListPart;
    SourceTable = "Data Support Buffer";

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
            }
        }
    }
}
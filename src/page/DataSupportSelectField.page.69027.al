page 69027 "Data Support Select Field"
{
    PageType = List;
    SourceTable = Field;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(FieldName; Rec.FieldName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
}
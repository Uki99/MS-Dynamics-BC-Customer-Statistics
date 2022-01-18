/// <summary>
/// Page BET CS Customer Statistics (ID 64850).
/// </summary>
page 64850 "BET CS Customer Statistics"
{
    Caption = 'Customer Statistics';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Customer;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the City field.';
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Registration No. field.';
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance (LCY) field.';
                }
                field("Period 1"; SalesAmountActualByMonth[1])
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SalesAmountActualByMonth[1] field.';
                    CaptionClass = '1,5,,' + PeriodCaptions[1];
                    BlankZero = true;
                }
                field("Period 2"; SalesAmountActualByMonth[2])
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SalesAmountActualByMonth[2] field.';
                    CaptionClass = '1,5,,' + PeriodCaptions[2];
                    BlankZero = true;
                }
                field("Period 3"; SalesAmountActualByMonth[3])
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SalesAmountActualByMonth[3] field.';
                    CaptionClass = '1,5,,' + PeriodCaptions[3];
                    BlankZero = true;
                }
                field("Period 4"; SalesAmountActualByMonth[4])
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SalesAmountActualByMonth[4] field.';
                    CaptionClass = '1,5,,' + PeriodCaptions[4];
                    BlankZero = true;
                }
                field("Period 5"; SalesAmountActualByMonth[5])
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SalesAmountActualByMonth[5] field.';
                    CaptionClass = '1,5,,' + PeriodCaptions[5];
                    BlankZero = true;
                }
                field("Period 6"; SalesAmountActualByMonth[6])
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SalesAmountActualByMonth[6] field.';
                    CaptionClass = '1,5,,' + PeriodCaptions[6];
                    BlankZero = true;
                }
                field("Period 7"; SalesAmountActualByMonth[7])
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SalesAmountActualByMonth[7] field.';
                    CaptionClass = '1,5,,' + PeriodCaptions[7];
                    BlankZero = true;
                }
                field("Period 8"; SalesAmountActualByMonth[8])
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SalesAmountActualByMonth[8] field.';
                    CaptionClass = '1,5,,' + PeriodCaptions[8];
                    BlankZero = true;
                }
                field("Period 9"; SalesAmountActualByMonth[9])
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SalesAmountActualByMonth[9] field.';
                    CaptionClass = '1,5,,' + PeriodCaptions[9];
                    BlankZero = true;
                }
                field("Period 10"; SalesAmountActualByMonth[10])
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SalesAmountActualByMonth[10] field.';
                    CaptionClass = '1,5,,' + PeriodCaptions[10];
                    BlankZero = true;
                }
                field("Period 11"; SalesAmountActualByMonth[11])
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SalesAmountActualByMonth[11] field.';
                    CaptionClass = '1,5,,' + PeriodCaptions[11];
                    BlankZero = true;
                }
                field("Period 12"; SalesAmountActualByMonth[12])
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SalesAmountActualByMonth[12] field.';
                    CaptionClass = '1,5,,' + PeriodCaptions[12];
                    BlankZero = true;
                }
                field("Sales Amount Actual Sum"; SalesAmountActualSum)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SalesAmountActualSum field.';
                    Caption = 'Sales Amount Actual Sum';
                    BlankZero = true;
                }
                field("Cost Amount Actual Sum"; CostAmountActualSum)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CostAmountActualSum field.';
                    Caption = 'Cost Amount Actual Sum';
                    BlankZero = true;
                }
            }
        }
    }

    var
        SalesAmountActualByMonth: Array[12] of Decimal;
        SalesAmountActualSum: Decimal;
        CostAmountActualSum: Decimal;
        PeriodCaptions: Array[12] of Text[100];

    trigger OnOpenPage()
    begin
        GenerateCaptions();
    end;

    trigger OnAfterGetRecord()
    begin
        GenerateCustomerData();
    end;

    local procedure GenerateCaptions()
    var
        Date: Record Date;
        CaptionIndex: Integer;
        CaptionTok: Label 'Sales Amount %1 %2', Comment = '%1 is name of the month, %2 is year of that month';
    begin
        GenerateDates(Date);
        CaptionIndex := 1;

        repeat
            PeriodCaptions[CaptionIndex] := StrSubstNo(CaptionTok, Date."Period Name", Date2DMY(Date."Period Start", 3));
            CaptionIndex += 1;
        until Date.Next() = 0;
    end;

    local procedure GenerateCustomerData()
    var
        ValueEntry: Record "Value Entry";
        Date: Record Date;
        Index: Integer;
    begin
        ResetPerCustomerSums();
        GenerateDates(Date);
        Index := 1;

        repeat
            Clear(ValueEntry);
            ValueEntry.SetRange("Source No.", Rec."No.");
            ValueEntry.SetRange("Source Type", ValueEntry."Source Type"::Customer);
            ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Sale);
            ValueEntry.SetFilter("Posting Date", '%1..%2', Date."Period Start", Date."Period End");

            ValueEntry.CalcSums("Sales Amount (Actual)", "Cost Amount (Actual)");
            SalesAmountActualByMonth[Index] := ValueEntry."Sales Amount (Actual)";
            SalesAmountActualSum += ValueEntry."Sales Amount (Actual)";
            CostAmountActualSum += ValueEntry."Cost Amount (Actual)";

            Index += 1;
        until Date.Next() = 0;
    end;

    local procedure ResetPerCustomerSums()
    begin
        SalesAmountActualSum := 0;
        CostAmountActualSum := 0;
    end;

    local procedure GenerateDates(var Date: Record Date)
    begin
        Date.SetRange("Period Type", Date."Period Type"::Month);
        Date.SetFilter("Period Start", '%1..%2', CalcDate('<CM-12M>', WorkDate()), WorkDate());
        Date.Ascending(false);
        Date.FindSet();
    end;
}
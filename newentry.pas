unit NewEntry;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, Types;

type

  { TNewCodeEntryDlg }

  TNewCodeEntryDlg = class(TForm)
    BitBtn1: TBitBtn;
    Button1: TButton;
    NCLang_Select: TComboBox;
    NCType_Select: TComboBox;
    NCLangLabel: TLabel;
    NCTypeLabel: TLabel;
    NewCodeName: TLabeledEdit;
    NewCodeGroupBox: TGroupBox;
    procedure Button1Click(Sender: TObject);
    procedure NCLang_SelectDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure NCType_SelectDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
  private

  public

  end;

var
  NewCodeEntryDlg: TNewCodeEntryDlg;

implementation

{$R *.lfm}

Uses MainForm, Translate_strings, LcLType;

{ TNewCodeEntryDlg }

procedure TNewCodeEntryDlg.NCLang_SelectDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var stra : array of string;
begin
 with (Control as Tcombobox) do
  begin
   Canvas.Brush := Brush;
   if (odSelected in State) then
    Canvas.Brush.Color := clHighLight;
   Canvas.Font := Font;
   Canvas.FillRect(aRect);
   stra:=Items[index].split('_');
   if (stra[1] > '') then
    Canvas.TextOut(aRect.Left, aRect.Top,stra[1])
   else
    Canvas.TextOut(aRect.Left, aRect.Top,Items[Index]);
  end;
end;


procedure TNewCodeEntryDlg.Button1Click(Sender: TObject);
begin
 if(Trim(NewCodeName.text)='') then
  messagedlgpos(Dlgstr3,mtInformation,[mbOk],0,round(SchnipselMainForm.left+(SchnipselMainForm.width/2)),round(SchnipselMainForm.top+(SchnipselMainForm.height/2)))
 else
  Self.ModalResult := mrOK;
end;


procedure TNewCodeEntryDlg.NCType_SelectDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var stra : array of string;
begin
 with (Control as Tcombobox) do
  begin
   Canvas.Brush := Brush;
   if (odSelected in State) then
    Canvas.Brush.Color := clHighLight;
   Canvas.Font := Font;
   Canvas.FillRect(aRect);
   stra:=Items[index].split('_');
   if (stra[1] > '') then
    Canvas.TextOut(aRect.Left, aRect.Top,stra[1])
   else
    Canvas.TextOut(aRect.Left, aRect.Top,Items[Index]);
  end;
end;


end.


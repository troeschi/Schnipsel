{    <Part of "Schnipsel".
     Database driven Apllication to collect Code-snippets or Script-snippets or
	 even just Text-snippets.>

    Copyright (C) 2025  A.Trösch

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

    Source-Code on Github: https://github.com/troeschi/Schnipsel
    Email-contact: troesch.andreas@gmx.de	                            }

// Form (Window) to add new snippets

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
    procedure FormCreate(Sender: TObject);
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
  messagedlgpos(Dlgstr3,mtInformation,[mbOk],0,round(left+(width/2)),round(top+(height/2)))
 else
  Self.ModalResult := mrOK;
end;

procedure TNewCodeEntryDlg.FormCreate(Sender: TObject);
begin
 font:=SchnipselMainForm.Font;
 NewCodeGroupBox.Font.style:=NewCodeGroupBox.Font.style+[fsBold];
 NCLang_Select.Font:=Font;
 NCType_Select.Font:=Font;
 NewCodeName.Font:=Font;
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


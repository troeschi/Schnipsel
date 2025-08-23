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
    Email-contact: troesch.andreas@gmx.details	                            }

// Form (Window) to add / edit / delete links of snippets

unit CodeLinks;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, Types;

type

  { TLinkDlg }

  TLinkDlg = class(TForm)
    BitBtn1: TBitBtn;
    Save_Btn: TButton;
    Label3: TLabel;
    LinkTXT1: TLabeledEdit;
    LinkUrl: TLabeledEdit;
    LinkTXT: TLabeledEdit;
    LinkUrl1: TLabeledEdit;
    Link_Select: TComboBox;
    LfCLabel2: TLabel;
    Lfc_Select: TComboBox;
    New_GroupBox: TGroupBox;
    Edit_GroupBox: TGroupBox;
    LfCLabel: TLabel;
    Lfc_Select1: TComboBox;
    Update_Btn: TButton;
    Delete_Btn: TButton;
    procedure Lfc_Select1DrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure Lfc_Select1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Lfc_SelectDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure Lfc_SelectMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Link_SelectDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure Link_SelectMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Link_SelectSelect(Sender: TObject);
    procedure Update_BtnClick(Sender: TObject);
    procedure Save_BtnClick(Sender: TObject);
    procedure Delete_BtnClick(Sender: TObject);
  private

  public

  end;

var
  LinkDlg: TLinkDlg;

implementation

{$R *.lfm}

uses MainForm, Translate_strings, LcLType, sqldb;

{ TLinkDlg }

procedure TLinkDlg.Save_BtnClick(Sender: TObject);
var To_id,i,
    Co_id : integer;
    s     : array of string;
begin
 if(trim(LinkTXT.text) > '') and (trim(LinkUrl.text) > '') then
  begin
   try
    SchnipselMainForm.SQLQuery1.SQL.Text := 'insert into schnipsel_links (id,code_id,link_text,link_url) values(NULL,:Code_id,:LinkTXT,:LinkUrl)';
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Code_id').asInteger:=SchnipselMainForm.Selected_Code_ID;
    SchnipselMainForm.SQLQuery1.Params.ParamByName('LinkTXT').asString:=trim(LinkTXT.text);
    SchnipselMainForm.SQLQuery1.Params.ParamByName('LinkUrl').asString:=trim(LinkUrl.text);
    SchnipselMainForm.SQLQuery1.ExecSQL;
    SchnipselMainForm.SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));

   end;
   if (SchnipselMainForm.SQLQuery1.RowsAffected > 0) then
    begin
     try
      if(SchnipselMainForm.DBEngine='SQLite') then
       SchnipselMainForm.SQLQuery1.SQL.Text := 'SELECT last_insert_rowid() as Last_id from schnipsel_links'
      else
       SchnipselMainForm.SQLQuery1.SQL.Text := 'SELECT LAST_INSERT_ID(Id) as Last_id from schnipsel_links order by LAST_INSERT_ID(Id) desc limit 1';
      SchnipselMainForm.SQLQuery1.Open;
      i:=SchnipselMainForm.SQLQuery1.FieldByName('Last_id').AsInteger;
      SchnipselMainForm.SQLQuery1.Close;
     except
       on E: ESQLDatabaseError do
             messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
     end;
     Link_Select.Items.add(inttostr(i)+'_'+trim(LinkTXT.text)+' | '+trim(LinkUrl.text));
     Link_Select.ItemIndex:=0;
     LinkTXT.text:='';
     LinkUrl.text:='';
    end;
  end;
end;


procedure TLinkDlg.Delete_BtnClick(Sender: TObject);
var s : array of string;
    L_id : integer;
begin
 if(Link_Select.ItemIndex=0) then
  MessageDlgPos(Dlgstr1,mtInformation,[mbok],0,round(left+(width/2)),round(top+(height/2)))
 else
  begin
   s:=Link_Select.Items[Link_Select.ItemIndex].split('_');
   L_id:=strtoint(s[0]);
   if(MessageDlgPos(Dlgstr2,mtConfirmation,[mbYes,mbNo],0,round(left+(width/2)),round(top+(height/2))) = mrYes) then
    begin
     try
      SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_links where id=:L_id';
      SchnipselMainForm.SQLQuery1.Params.ParamByName('L_id').asInteger:=L_id;
      SchnipselMainForm.SQLQuery1.ExecSQL;
      SchnipselMainForm.SQLTransaction1.Commit;
     except
      on E: ESQLDatabaseError do
             messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
     end;
     Link_Select.Items.delete(Link_Select.ItemIndex);
     Link_Select.ItemIndex:=0;
     LinkTXT1.text:='';
     LinkUrl1.Text:='';
    end;
  end;
end;


procedure TLinkDlg.Update_BtnClick(Sender: TObject);
var To_id : integer;
    Co_id : integer;
    s     : array of string;
begin
 if(trim(LinkTXT1.text) > '') and (trim(LinkUrl1.text) > '') and (Link_Select.ItemIndex > 0)then
  begin
   s:=Link_Select.Items[Link_Select.ItemIndex].split('_');
   To_id:=strtoint(s[0]);
   try
    SchnipselMainForm.SQLQuery1.SQL.Text := 'update schnipsel_links set code_id=:Code_id, link_text=:LinkTXT, link_url=:LinkUrl where id=:To_id';
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Code_id').asInteger:=SchnipselMainForm.Selected_Code_ID;
    SchnipselMainForm.SQLQuery1.Params.ParamByName('To_id').asInteger:=To_id;
    SchnipselMainForm.SQLQuery1.Params.ParamByName('LinkTXT').asString:=trim(LinkTXT1.text);
    SchnipselMainForm.SQLQuery1.Params.ParamByName('LinkUrl').asString:=trim(LinkUrl1.text);
    SchnipselMainForm.SQLQuery1.ExecSQL;
    SchnipselMainForm.SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   Link_Select.Items[Link_Select.ItemIndex]:=inttostr(To_id)+'_'+trim(LinkTXT1.text)+' | '+trim(LinkUrl1.text);
   Link_Select.ItemIndex:=0;
   LinkTXT1.text:='';
   LinkUrl1.text:='';
  end;
end;


procedure TLinkDlg.Link_SelectSelect(Sender: TObject);
var s : array of string;
begin
 s:=Link_Select.Items[Link_Select.ItemIndex].split('|');
 LinkTXT1.text:=trim(copy(s[0],pos('_',s[0])+1,length(s[0])));
 LinkUrl1.text:=trim(s[1]);
end;


procedure TLinkDlg.Lfc_SelectDrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
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


procedure TLinkDlg.Lfc_SelectMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  s: string;
  TC : TCombobox;
begin
 TC:=(Sender as TComboBox);
 S:=TC.Items[TC.ItemIndex];
 if(TC.Canvas.Textwidth(s) > TC.Width-10) then
  begin
   TC.showhint:=True;
   TC.hint:=s;
  end
 else
  TC.showhint:=false;
end;


procedure TLinkDlg.Lfc_Select1DrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
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


procedure TLinkDlg.Lfc_Select1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  s: string;
  TC : TCombobox;
begin
 TC:=(Sender as TComboBox);
 S:=TC.Items[TC.ItemIndex];
 if(TC.Canvas.Textwidth(s) > TC.Width-10) then
  begin
   TC.showhint:=True;
   TC.hint:=s;
  end
 else
  TC.showhint:=false;
end;


procedure TLinkDlg.Link_SelectDrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
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


procedure TLinkDlg.Link_SelectMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  s: string;
  TC : TCombobox;
begin
 TC:=(Sender as TComboBox);
 S:=TC.Items[TC.ItemIndex];
 if(TC.Canvas.Textwidth(s) > TC.Width-10) then
  begin
   TC.showhint:=True;
   TC.hint:=s;
  end
 else
  TC.showhint:=false;
end;


end.

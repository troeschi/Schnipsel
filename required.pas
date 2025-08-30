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

// Form (Window) to add / edit / delete required things of snippets

unit Required;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, Types;

type

  { TRequiredDlg }

  TRequiredDlg = class(TForm)
    Delete_Btn: TButton;
    CloseBtn: TBitBtn;
    ReqEdit_Select: TComboBox;
    EReq_Label: TLabel;
    Save_Btn: TButton;
    Save_Btn2: TButton;
    Code_inBase1: TComboBox;
    NewGroup: TGroupBox;
    EditGroup: TGroupBox;
    CiB_Label2: TLabel;
    Req_hint1: TLabeledEdit;
    Req_name1: TLabeledEdit;
    Req_url1: TLabeledEdit;
    RfC_Label1: TLabel;
    RfC_Select: TComboBox;
    Code_inBase: TComboBox;
    RfC_Label: TLabel;
    CiB_Label: TLabel;
    Req_name: TLabeledEdit;
    Req_hint: TLabeledEdit;
    Req_url: TLabeledEdit;
    RfC_Select1: TComboBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure Code_inBase1DrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure Code_inBase1MouseMove(Sender: TObject);
    procedure Code_inBaseDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure Code_inBaseMouseMove(Sender: TObject);
    procedure Delete_BtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ReqEdit_SelectDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure ReqEdit_SelectMouseMove(Sender: TObject);
    procedure ReqEdit_SelectSelect(Sender: TObject);
    procedure RfC_Select1DrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure RfC_Select1MouseMove(Sender: TObject);
    procedure RfC_SelectDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure RfC_SelectMouseMove(Sender: TObject);
    procedure Save_Btn2Click(Sender: TObject);
    procedure Save_BtnClick(Sender: TObject);
  private

  public

  end;

var
  RequiredDlg: TRequiredDlg;

implementation

{$R *.lfm}

uses MainForm, Translate_strings, LcLType, sqldb, LCLTranslator, LCLIntf;

{ TRequiredDlg }

procedure TRequiredDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if(key=112) then
  if(setdefaultlang('')='de') then
   openurl('Schnipsel.chm')
  else
   openurl('Schnipsel_'+setdefaultlang('')+'.chm');
end;


procedure TRequiredDlg.RfC_SelectDrawItem(Control: TWinControl; Index: Integer;
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


procedure TRequiredDlg.RfC_SelectMouseMove(Sender: TObject);
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


procedure TRequiredDlg.Save_Btn2Click(Sender: TObject);
var To_id : integer;
    R_id  : integer;
    s     : array of string;
begin
 if(trim(Req_name1.text) > '') and (trim(Req_hint1.text) > '') and (trim(Req_url1.text) > '') and (ReqEdit_Select.ItemIndex > 0)then
  begin
   if(Code_inBase1.ItemIndex > 0) then
    begin
     s:=Code_inBase1.Items[Code_inBase1.ItemIndex].split('_');
     R_id:=strtoint(s[0]);
    end
   else R_id:=0;
   s:=ReqEdit_Select.Items[ReqEdit_Select.ItemIndex].split('_');
   To_id:=strtoint(s[0]);
   try
    SchnipselMainForm.SQLQuery1.SQL.Text := 'update schnipsel_required set code_id=:Code_id, required_id=:Rid, required_name=:Rname, required_hint=:Rhint, required_link=:Rurl where id=:To_id';
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Code_id').asInteger:=SchnipselMainForm.Selected_Code_ID;
    SchnipselMainForm.SQLQuery1.Params.ParamByName('To_id').asInteger:=To_id;
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Rid').asInteger:=R_id;
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Rname').asString:=trim(Req_name1.text);
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Rhint').asString:=trim(Req_hint1.text);
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Rurl').asString:=trim(req_url1.text);
    SchnipselMainForm.SQLQuery1.ExecSQL;
    SchnipselMainForm.SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   Req_name1.text:='';
   Req_hint1.text:='';
   Req_url1.text:='';
   ReqEdit_Select.ItemIndex:=0;
   Code_inBase1.ItemIndex:=0;
   Code_inBase.Items[To_id]:=s[0]+'_'+trim(Req_name1.text)+' | '+trim(Req_hint1.text)+' | '+trim(req_url1.text);
   Code_inBase1.Items[To_id]:=s[0]+'_'+trim(Req_name1.text)+' | '+trim(Req_hint1.text)+' | '+trim(req_url1.text);
  end;
end;


procedure TRequiredDlg.Save_BtnClick(Sender: TObject);
var s : array of string;
    i : integer;
begin
 if(trim(Req_name.text) > '') and (trim(Req_hint.text) > '') then
  begin
   if (Code_inBase.ItemIndex > 0) then
    begin
     s:=Code_inBase.Items[Code_inBase.ItemIndex].split('_');
     i:=strtoint(s[0]);
    end
   else i:=0;
   try
    SchnipselMainForm.SQLQuery1.SQL.Text := 'insert into schnipsel_required (id, code_id, required_id, required_name, required_hint, required_link) VALUES (NULL, :Code_ID, :Rid, :Rname, :Rhint, :Rurl)';
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Code_id').asInteger:=SchnipselMainForm.Selected_Code_ID;
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Rid').asInteger:=i;
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Rname').asString:=trim(Req_name.text);
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Rhint').asString:=trim(Req_hint.text);
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Rurl').asString:=trim(req_url.text);
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
        SchnipselMainForm.SQLQuery1.SQL.Text := 'SELECT last_insert_rowid() as Last_id from schnipsel_required'
       else
        SchnipselMainForm.SQLQuery1.SQL.Text := 'SELECT LAST_INSERT_ID(Id) as Last_id from schnipsel_required order by LAST_INSERT_ID(Id) desc limit 1';
       SchnipselMainForm.SQLQuery1.Open;
       i:=SchnipselMainForm.SQLQuery1.FieldByName('Last_id').AsInteger;
       SchnipselMainForm.SQLQuery1.Close;
      except
       on E: ESQLDatabaseError do
              messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
      end;
      ReqEdit_Select.Items.add(inttostr(i)+'_'+trim(Req_name.text)+' | '+trim(Req_hint.text)+' | '+trim(Req_url.text));
      Req_name.text:='';
      Req_hint.text:='';
      Req_url.text:='';
      Code_inBase.ItemIndex:=0;
     end;
  end;
end;


procedure TRequiredDlg.Code_inBaseDrawItem(Control: TWinControl;
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


procedure TRequiredDlg.Code_inBaseMouseMove(Sender: TObject);
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


procedure TRequiredDlg.Delete_BtnClick(Sender: TObject);
var s : array of string;
    R_id : integer;
begin
  if(ReqEdit_Select.ItemIndex=0) then
   MessageDlgPos(Dlgstr1,mtInformation,[mbok],0,round(left+(width/2)),round(top+(height/2)))
 else
  begin
   s:=ReqEdit_Select.Items[ReqEdit_Select.ItemIndex].split('_');
   R_id:=strtoint(s[0]);
   if(MessageDlgPos(Dlgstr2,mtConfirmation,[mbYes,mbNo],0,round(left+(width/2)),round(top+(height/2))) = mrYes) then
    begin
     try
      SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_required where id=:R_id';
      SchnipselMainForm.SQLQuery1.Params.ParamByName('R_id').asInteger:=R_id;
      SchnipselMainForm.SQLQuery1.ExecSQL;
      SchnipselMainForm.SQLTransaction1.Commit;
     except
      on E: ESQLDatabaseError do
             messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
     end;
     ReqEdit_Select.Items.Delete(ReqEdit_Select.ItemIndex);
     ReqEdit_Select.ItemIndex:=0;
     Req_name1.text:='';
     Req_hint1.text:='';
     Req_url1.text:='';
    end;
  end;
end;


procedure TRequiredDlg.FormCreate(Sender: TObject);
begin
 Font:=SchnipselMainForm.Font;
 NewGroup.Font.style:=NewGroup.Font.style+[fsBold];
 EditGroup.Font.style:=EditGroup.Font.style+[fsBold];
 Rfc_Select.Font:=Font;
 Req_Name.Font:=Font;
 Req_Hint.Font:=Font;
 Req_Url.Font:=Font;
 Code_inBase.Font:=Font;
 Req_Name1.Font:=Font;
 Rfc_Select1.Font:=Font;
 Req_Hint1.Font:=Font;
 Req_Url1.Font:=Font;
 Code_inBase1.Font:=Font;
 ReqEdit_Select.Font:=Font;
end;


procedure TRequiredDlg.Code_inBase1DrawItem(Control: TWinControl;
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


procedure TRequiredDlg.Code_inBase1MouseMove(Sender: TObject);
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


procedure TRequiredDlg.ReqEdit_SelectDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var stra : array of string;
    i    : integer;
begin
 with (Control as Tcombobox) do
  begin
   Canvas.Brush := Brush;
   if (odSelected in State) then
    Canvas.Brush.Color := clHighLight;
   Canvas.Font := Font;
   Canvas.FillRect(aRect);
   stra:=Items[index].split('_');
   if(high(stra) > 1) then
    for i:=2 to high(stra) do
     stra[1]:=stra[1]+'_'+stra[i];
   if (stra[1] > '') then
    Canvas.TextOut(aRect.Left, aRect.Top,stra[1])
   else
    Canvas.TextOut(aRect.Left, aRect.Top,Items[Index]);
  end;
end;


procedure TRequiredDlg.ReqEdit_SelectMouseMove(Sender: TObject);
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


procedure TRequiredDlg.ReqEdit_SelectSelect(Sender: TObject);
var s : array of string;
begin
 s:=ReqEdit_Select.Items[ReqEdit_Select.ItemIndex].split('|');
 Req_name1.text:=trim(copy(s[0],pos('_',s[0])+1,length(s[0])));
 Req_hint1.text:=trim(s[1]);
 Req_url1.text:=trim(s[2]);
end;


procedure TRequiredDlg.RfC_Select1DrawItem(Control: TWinControl;
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


procedure TRequiredDlg.RfC_Select1MouseMove(Sender: TObject);
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


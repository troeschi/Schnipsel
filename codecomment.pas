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

// Form (Window) to add / edit / delete comments of snippets

unit CodeComment;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, Types;

type

  { TCommentDlg }

  TCommentDlg = class(TForm)
    BitBtn1: TBitBtn;
    Delete_Btn: TButton;
    Update_Btn: TButton;
    Save_Btn: TButton;
    CAuthorEdit: TLabeledEdit;
    EditCom_Select: TComboBox;
    Label1: TLabel;
    New_Comment: TLabeledEdit;
    CfC_Label1: TLabel;
    CfC_Select: TComboBox;
    CfC_Select1: TComboBox;
    New_GroupBox: TGroupBox;
    Edit_GroupBox: TGroupBox;
    CfC_Label: TLabel;
    CAuthor: TLabeledEdit;
    Edit_Comment: TLabeledEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure CfC_Select1DrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure CfC_Select1MouseMove(Sender: TObject);
    procedure CfC_SelectDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure CfC_SelectMouseMove(Sender: TObject);
    procedure Delete_BtnClick(Sender: TObject);
    procedure EditCom_SelectDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure EditCom_SelectMouseMove(Sender: TObject);
    procedure EditCom_SelectSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Update_BtnClick(Sender: TObject);
    procedure Save_BtnClick(Sender: TObject);
  private

  public

  end;

var
  CommentDlg: TCommentDlg;

implementation

{$R *.lfm}

uses MainForm, Translate_strings, LcLType, sqldb, LCLTranslator, LCLIntf;

{ TCommentDlg }

procedure TCommentDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if(key=112) then
  if(setdefaultlang('')='de') then
   openurl('Schnipsel.chm')
  else
   openurl('Schnipsel_'+setdefaultlang('')+'.chm');
end;


procedure TCommentDlg.CfC_SelectDrawItem(Control: TWinControl; Index: Integer;
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


procedure TCommentDlg.CfC_SelectMouseMove(Sender: TObject);
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


procedure TCommentDlg.Delete_BtnClick(Sender: TObject);
var s : array of string;
    Co_id : integer;
begin
 if(EditCom_Select.ItemIndex=0) then
  MessageDlgPos(Dlgstr1,mtInformation,[mbok],0,round(left+(width/2)),round(top+(height/2)))
 else
  begin
   s:=EditCom_Select.Items[EditCom_Select.ItemIndex].split('_');
   Co_id:=strtoint(s[0]);
   if(MessageDlgPos(Dlgstr2,mtConfirmation,[mbYes,mbNo],0,round(left+(width/2)),round(top+(height/2))) = mrYes) then
    begin
     try
      SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_comments where id=:Co_id';
      SchnipselMainForm.SQLQuery1.Params.ParamByName('Co_id').asInteger:=Co_id;
      SchnipselMainForm.SQLQuery1.ExecSQL;
      SchnipselMainForm.SQLTransaction1.Commit;
     except
      on E: ESQLDatabaseError do
             messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));

     end;
     EditCom_Select.Items.delete(EditCom_Select.ItemIndex);
     EditCom_Select.ItemIndex:=0;
     CAuthorEdit.text:='';
     Edit_Comment.Text:='';
    end;
  end;
end;


procedure TCommentDlg.CfC_Select1DrawItem(Control: TWinControl; Index: Integer;
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


procedure TCommentDlg.CfC_Select1MouseMove(Sender: TObject);
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


procedure TCommentDlg.EditCom_SelectDrawItem(Control: TWinControl;
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

procedure TCommentDlg.EditCom_SelectMouseMove(Sender: TObject);
var
  s: array of string;
  TC : TCombobox;
begin
 TC:=(Sender as TComboBox);
 S:=TC.Items[TC.ItemIndex].split('|');
 if(TC.Canvas.Textwidth(s[1]) > TC.Width-10) then
  begin
   TC.showhint:=True;
   TC.hint:=s[1];
  end
 else
  TC.showhint:=false;
end;


procedure TCommentDlg.EditCom_SelectSelect(Sender: TObject);
var s : array of string;
begin
 s:=EditCom_Select.Items[EditCom_Select.ItemIndex].split('|');
 CAuthorEdit.text:=trim(copy(s[0],pos('_',s[0])+1,length(s[0])));
 Edit_Comment.text:=trim(s[1]);
end;


procedure TCommentDlg.FormCreate(Sender: TObject);
begin
 Font:=SchnipselMainForm.Font;
 New_GroupBox.Font.style:=New_GroupBox.Font.style+[fsBold];
 Edit_GroupBox.Font.style:=Edit_GroupBox.Font.style+[fsBold];
 CFC_Select.Font:=Font;
 CAuthor.Font:=Font;
 New_Comment.Font:=Font;
 CFC_Select1.Font:=Font;
 CAuthorEdit.Font:=Font;
 Edit_Comment.Font:=Font;
 EditCom_Select.Font:=Font;
end;


procedure TCommentDlg.Update_BtnClick(Sender: TObject);
var To_id : integer;
    Co_id : integer;
    s     : array of string;
begin
 if(trim(CAuthorEdit.text) > '') and (trim(Edit_Comment.text) > '') and (EditCom_Select.ItemIndex > 0)then
  begin
   s:=EditCom_Select.Items[EditCom_Select.ItemIndex].split('_');
   To_id:=strtoint(s[0]);
   try
    SchnipselMainForm.SQLQuery1.SQL.Text := 'update schnipsel_comments set code_id=:Code_id, author=:CAuthor, comment=:Ccomment where id=:To_id';
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Code_id').asInteger:=SchnipselMainForm.Selected_Code_ID;
    SchnipselMainForm.SQLQuery1.Params.ParamByName('To_id').asInteger:=To_id;
    SchnipselMainForm.SQLQuery1.Params.ParamByName('CAuthor').asString:=trim(CAuthorEdit.text);
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Ccomment').asString:=trim(Edit_Comment.text);
    SchnipselMainForm.SQLQuery1.ExecSQL;
    SchnipselMainForm.SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));

   end;
   EditCom_Select.Items[EditCom_Select.ItemIndex]:=inttostr(To_id)+'_'+trim(CAuthorEdit.text)+' | '+trim(Edit_Comment.text);
   EditCom_Select.ItemIndex:=0;
   CAuthorEdit.text:='';
   Edit_Comment.text:='';
  end;
end;


procedure TCommentDlg.Save_BtnClick(Sender: TObject);
var To_id,i,
    Co_id : integer;
    s     : array of string;
begin
 if(trim(CAuthor.text) > '') and (trim(New_Comment.text) > '') then
  begin
   try
    SchnipselMainForm.SQLQuery1.SQL.Text := 'insert into schnipsel_comments (id,code_id,parent_id,author,comment) values(NULL,:Code_id,0,:CAuthor,:Ccomment)';
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Code_id').asInteger:=SchnipselMainForm.Selected_Code_ID;
    SchnipselMainForm.SQLQuery1.Params.ParamByName('CAuthor').asString:=trim(CAuthor.text);
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Ccomment').asString:=trim(New_Comment.text);
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
       SchnipselMainForm.SQLQuery1.SQL.Text := 'SELECT last_insert_rowid() as Last_id from schnipsel_comments'
      else
       SchnipselMainForm.SQLQuery1.SQL.Text := 'SELECT LAST_INSERT_ID(Id) as Last_id from schnipsel_comments order by LAST_INSERT_ID(Id) desc limit 1';
      SchnipselMainForm.SQLQuery1.Open;
      i:=SchnipselMainForm.SQLQuery1.FieldByName('Last_id').AsInteger;
      SchnipselMainForm.SQLQuery1.Close;
     except
       on E: ESQLDatabaseError do
              messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
     end;
     EditCom_Select.Items.add(inttostr(i)+'_'+trim(CAuthor.text)+' | '+trim(New_Comment.text));
     EditCom_Select.ItemIndex:=0;
     CAuthor.text:='';
     New_Comment.text:='';
    end;
  end;
end;


end.


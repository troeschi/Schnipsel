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

// Form (Window) for add / edit / delete types of coding languages

unit CodeTypes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, Types;

type

  { TNewTypeDlg }

  TNewTypeDlg = class(TForm)
    BitBtn1: TBitBtn;
    SaveBtn: TButton;
    StaticText1: TStaticText;
    UpdateBtn: TButton;
    DeleteBtn: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    DelLabel: TLabel;
    NewTypeName: TLabeledEdit;
    EditTypeName: TLabeledEdit;
    EditTypeListBox: TListBox;
    DeleteListBox: TListBox;
    MoveToListBox: TListBox;
    procedure DeleteBtnClick(Sender: TObject);
    procedure DeleteListBoxDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure EditTypeListBoxDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure EditTypeListBoxSelectionChange(Sender: TObject; User: boolean);
    procedure FormCreate(Sender: TObject);
    procedure MoveToListBoxDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure SaveBtnClick(Sender: TObject);
    procedure UpdateBtnClick(Sender: TObject);
  private

  public

  end;

var
  NewTypeDlg: TNewTypeDlg;

implementation

{$R *.lfm}

uses MainForm, Translate_strings, LcLType, sqldb;

{ TNewTypeDlg }

procedure TNewTypeDlg.EditTypeListBoxDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var stra : array of string;
begin
 with (Control as TListbox) do
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


procedure TNewTypeDlg.EditTypeListBoxSelectionChange(Sender: TObject;
  User: boolean);
var s     : array of string;
begin
 s:=EditTypeListBox.Items[EditTypeListBox.ItemIndex].split('_');
 EditTypeName.text:=trim(s[1]);
end;


procedure TNewTypeDlg.FormCreate(Sender: TObject);
begin
 Font:=SchnipselMainForm.Font;
 GroupBox1.Font.style:=GroupBox1.Font.style+[fsBold];
 GroupBox2.Font.style:=GroupBox2.Font.style+[fsBold];
 GroupBox3.Font.style:=GroupBox3.Font.style+[fsBold];
 NewTypeName.Font:=Font;
 EditTypeListBox.Font:=Font;
 EditTypeName.Font:=Font;
 DeleteListBox.Font:=Font;
 MoveToListBox.Font:=Font;
end;


procedure TNewTypeDlg.MoveToListBoxDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var stra : array of string;
begin
 with (Control as TListbox) do
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


procedure TNewTypeDlg.SaveBtnClick(Sender: TObject);
var i : integer;
begin
 if(trim(NewTypeName.text) > '') then
  begin
   try
    SchnipselMainForm.SQLQuery1.SQL.text:='insert into schnipsel_types (TypeName) values(:TypeName)';
    SchnipselMainForm.SQLQuery1.Params.ParamByName('TypeName').asString:=trim(NewTypeName.text).replace('_','-',[rfReplaceAll]);
    SchnipselMainForm.SQLQuery1.ExecSQL;
    SchnipselMainForm.SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   try
    if(SchnipselMainForm.DBEngine='SQLite') then
     SchnipselMainForm.SQLQuery1.SQL.Text := 'SELECT last_insert_rowid() as Last_id from schnipsel_types'
    else
     SchnipselMainForm.SQLQuery1.SQL.Text := 'SELECT LAST_INSERT_ID(Id) as Last_id from schnipsel_types order by LAST_INSERT_ID(Id) desc limit 1';
    SchnipselMainForm.SQLQuery1.Open;
    i:=SchnipselMainForm.SQLQuery1.FieldByName('Last_id').AsInteger;
    SchnipselMainForm.SQLQuery1.Close;
   except
    on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   edittypelistbox.Items.add(inttostr(i)+'_'+trim(NewTypeName.text).replace('_','-',[rfReplaceAll]));
   DeleteListBox.Items.add(inttostr(i)+'_'+trim(NewTypeName.text).replace('_','-',[rfReplaceAll]));
   MoveToListBox.Items.add(inttostr(i)+'_'+trim(NewTypeName.text).replace('_','-',[rfReplaceAll]));
   NewTypeName.text:='';
  end;
end;


procedure TNewTypeDlg.UpdateBtnClick(Sender: TObject);
var stra : array of string;
begin
 if(trim(NewTypeName.text) > '') then
  begin
   try
    SchnipselMainForm.SQLQuery1.SQL.text:='update schnipsel_types set TypeName=:TName where id=:Tid';
    stra:= edittypelistbox.Items[ edittypelistbox.ItemIndex].split('_');
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Tid').asInteger:=strtoint(trim(stra[0]));
    SchnipselMainForm.SQLQuery1.Params.ParamByName('TName').asString:=trim(EditTypeName.text).replace('_','-',[rfReplaceAll]);
    SchnipselMainForm.SQLQuery1.ExecSQL;
    SchnipselMainForm.SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   edittypelistbox.Items[edittypelistbox.ItemIndex]:=trim(stra[0])+'_'+trim(EditTypeName.text).replace('_','-',[rfReplaceAll]);
   DeleteListBox.Items[edittypelistbox.ItemIndex]:=trim(stra[0])+'_'+trim(EditTypeName.text).replace('_','-',[rfReplaceAll]);
   MoveToListBox.Items[edittypelistbox.ItemIndex]:=trim(stra[0])+'_'+trim(EditTypeName.text).replace('_','-',[rfReplaceAll]);
  end;
end;


procedure TNewTypeDlg.DeleteListBoxDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var stra : array of string;
begin
 with (Control as TListbox) do
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


procedure TNewTypeDlg.DeleteBtnClick(Sender: TObject);
var stra          : array of string;
    fstr,tstr     : string;
    from_id,to_id : integer;
    msg_ask       : string;
begin
  stra:=DeleteListBox.Items[DeleteListBox.ItemIndex].split('_');
  from_id:=strtoint(stra[0]);
  fstr:=trim(stra[1]);
  stra:=MoveToListBox.Items[MoveToListBox.ItemIndex].split('_');
  tstr:=trim(stra[1]);
  to_id:=strtoint(stra[0]);
  if(from_id <> to_id) then
   msg_ask:=Dlgstr4+' '+fstr+' '+Dlgstr5+' '+tstr+' '+Dlgstr6+' '+fstr+' '+Dlgstr7
  else
   msg_ask:=Dlgstr8+' '+fstr+' '+Dlgstr6+' '+fstr+' '+Dlgstr7;
  if(messageDlgPos(msg_ask,mtConfirmation,
                [mbYes,mbNo],0,round(left+(width/2)),round(top+(height/2))) = mrYes) then
   begin
    try
     if(from_id <> to_id) then
      begin
       SchnipselMainForm.SQLQuery1.SQL.text:='update schnipsel_names set type_id=:Tid where type_id=:fid';
       SchnipselMainForm.SQLQuery1.Params.ParamByName('Tid').asInteger:=to_id;
       SchnipselMainForm.SQLQuery1.ExecSQL;
       SchnipselMainForm.SQLTransaction1.Commit;
      end
     else
      begin
       SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_favorites where exists (select * from schnipsel_names where schnipsel_names.type_id=:Del_id and schnipsel_names.id=schnipsel_favorites.schnipsel_id)';
       SchnipselMainForm.SQLQuery1.Params.ParamByName('Del_id').asInteger:=to_id;
       SchnipselMainForm.SQLQuery1.ExecSQL;
       SchnipselMainForm.SQLTransaction1.Commit;
       SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_bookmarks where exists (select * from schnipsel_names where schnipsel_names.type_id=:Del_id and schnipsel_names.id=schnipsel_bookmarks.schnipsel_id)';
       SchnipselMainForm.SQLQuery1.Params.ParamByName('Del_id').asInteger:=to_id;
       SchnipselMainForm.SQLQuery1.ExecSQL;
       SchnipselMainForm.SQLTransaction1.Commit;
       SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_links where exists (select * from schnipsel_names where schnipsel_names.type_id=:Del_id and schnipsel_names.id=schnipsel_links.code_id)';
       SchnipselMainForm.SQLQuery1.Params.ParamByName('Del_id').asInteger:=to_id;
       SchnipselMainForm.SQLQuery1.ExecSQL;
       SchnipselMainForm.SQLTransaction1.Commit;
       SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_required where exists (select * from schnipsel_names where schnipsel_names.type_id=:Del_id and schnipsel_names.id=schnipsel_required.code_id)';
       SchnipselMainForm.SQLQuery1.Params.ParamByName('Del_id').asInteger:=to_id;
       SchnipselMainForm.SQLQuery1.ExecSQL;
       SchnipselMainForm.SQLTransaction1.Commit;
       SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_comments where exists (select * from schnipsel_names where schnipsel_names.type_id=:Del_id and schnipsel_names.id=schnipsel_comments.code_id)';
       SchnipselMainForm.SQLQuery1.Params.ParamByName('Del_id').asInteger:=to_id;
       SchnipselMainForm.SQLQuery1.ExecSQL;
       SchnipselMainForm.SQLTransaction1.Commit;
       SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_codes where exists (select * from schnipsel_names where schnipsel_names.type_id=:Del_id and schnipsel_names.id=schnipsel_codes.schnipsel_id)';
       SchnipselMainForm.SQLQuery1.Params.ParamByName('Del_id').asInteger:=to_id;
       SchnipselMainForm.SQLQuery1.ExecSQL;
       SchnipselMainForm.SQLTransaction1.Commit;
       SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_names where type_id=:Del_id';
       SchnipselMainForm.SQLQuery1.Params.ParamByName('Del_id').asInteger:=to_id;
       SchnipselMainForm.SQLQuery1.ExecSQL;
       SchnipselMainForm.SQLTransaction1.Commit;
      end;
     except
     on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
    end;
    try
     SchnipselMainForm.SQLQuery1.SQL.text:='delete from schnipsel_types where id=:fid';
     SchnipselMainForm.SQLQuery1.Params.ParamByName('Fid').asInteger:=from_id;
     SchnipselMainForm.SQLQuery1.ExecSQL;
     SchnipselMainForm.SQLTransaction1.Commit;
    except
     on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
    end;
    Edittypelistbox.Items.Delete(DeleteListBox.ItemIndex);
    MoveToListBox.Items.Delete(DeleteListBox.ItemIndex);
    DeleteListBox.Items.Delete(DeleteListBox.ItemIndex);
   end;
end;


end.


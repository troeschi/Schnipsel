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

// Form (Window) to add / edit / delete coding languages

unit Languages;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, ComCtrls, DividerBevel, Types;

type

  { TNewCategorieDlg }

  TNewCategorieDlg = class(TForm)
    MoveToCategorie1: TStaticText;
    MoveToListBox: TListBox;
    SaveBtn: TButton;
    SaveBtn2: TButton;
    DeleteBtn: TButton;
    CategorieListDelete: TListBox;
    DividerBevel1: TDividerBevel;
    DividerBevel2: TDividerBevel;
    DividerBevel3: TDividerBevel;
    NewImage: TImage;
    CategorieListEdit: TListBox;
    EditImage: TImage;
    DeleteImage: TImage;
    NewCatName1: TLabeledEdit;
    NewCatShort1: TLabeledEdit;
    CloseBtn: TBitBtn;
    NewCatName: TLabeledEdit;
    NewCatShort: TLabeledEdit;
    NewCategorie: TStaticText;
    EditCategorie: TStaticText;
    DeleteCategorie: TStaticText;
    procedure CategorieListDeleteDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure CategorieListEditDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure CategorieListEditSelectionChange(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure MoveToListBoxDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure SaveBtn2Click(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
  private

  public

  end;


var
  NewCategorieDlg : TNewCategorieDlg;


implementation

{$R *.lfm}

uses MainForm, sqldb, LcLType, Translate_strings;

{ TNewCategorieDlg }


procedure TNewCategorieDlg.DeleteBtnClick(Sender: TObject);
var i          : integer;
    del        : boolean;
    fstr,
    tstr       : string;
    del_id     : array of string;
    move_to_id : array of string;
begin
 del:=false;
 del_id:=CategorieListDelete.Items[CategorieListDelete.ItemIndex].split('_');
 fstr:=trim(del_id[1]);
 move_to_id:=MoveToListBox.Items[MoveToListBox.ItemIndex].split('_');
 tstr:=trim(move_to_id[1]);
 if(messageDlgPos(Dlgstr4+' '+fstr+' '+Dlgstr5+' '+tstr+' '+Dlgstr6+' '+fstr+' '+Dlgstr7,mtConfirmation,
                [mbYes,mbNo],0,round(left+(width/2)),round(top+(height/2))) = mrYes) then
 begin
  if(CategorieListDelete.count > 1) then
   begin
    i:=CategorieListDelete.ItemIndex;
    if(i < CategorieListDelete.count-1) then
     begin
      CategorieListDelete.Items.Delete(i);
      CategorieListDelete.ItemIndex:=i+1;
      del:=true;
     end
    else
     begin
      CategorieListDelete.Items.Delete(i);
      CategorieListDelete.ItemIndex:=0;
      del:=true;
     end;
   if(i < CategorieListEdit.count-1) then
    begin
     CategorieListEdit.Items.Delete(i);
     CategorieListEdit.ItemIndex:=i+1;
     del:=true;
    end
   else
    begin
     CategorieListEdit.Items.Delete(i);
     CategorieListEdit.ItemIndex:=0;
     del:=true;
    end;
   if(i < MoveToListBox.count-1) then
    begin
     MoveToListBox.Items.Delete(i);
     MoveToListBox.ItemIndex:=i+1;
     del:=true;
    end
   else
    begin
     MoveToListBox.Items.Delete(i);
     MoveToListBox.ItemIndex:=0;
     del:=true;
    end;
   end
  else
   del:=true;
  if(del=true) then
   begin
    try
      SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_language where id=:Del_id';
      SchnipselMainForm.SQLQuery1.Params.ParamByName('Del_id').asInteger:=strtoint(trim(Del_id[0]));
      SchnipselMainForm.SQLQuery1.ExecSQL;
      SchnipselMainForm.SQLTransaction1.Commit;
    except
      on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
    end;
    try
      if(del_id[0] <> move_to_id[0]) then
       begin
        showmessage('false');
        SchnipselMainForm.SQLQuery1.SQL.Text := 'update schnipsel_names set Lang_id=:Move_To_id where Lang_id=:Del_id';
        SchnipselMainForm.SQLQuery1.Params.ParamByName('Del_id').asInteger:=strtoint(trim(Del_id[0]));
        SchnipselMainForm.SQLQuery1.Params.ParamByName('Move_To_id').asInteger:=strtoint(trim(Move_to_id[0]));
        SchnipselMainForm.SQLQuery1.ExecSQL;
        SchnipselMainForm.SQLTransaction1.Commit;
       end
      else
       begin
        showmessage('true');
        SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_favorites where exists (select * from schnipsel_names where schnipsel_names.Lang_id=:Del_id and schnipsel_names.id=schnipsel_favorites.schnipsel_id)';
        SchnipselMainForm.SQLQuery1.Params.ParamByName('Del_id').asInteger:=strtoint(trim(Del_id[0]));
        SchnipselMainForm.SQLQuery1.ExecSQL;
        SchnipselMainForm.SQLTransaction1.Commit;
        SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_bookmarks where exists (select * from schnipsel_names where schnipsel_names.Lang_id=:Del_id and schnipsel_names.id=schnipsel_bookmarks.schnipsel_id)';
        SchnipselMainForm.SQLQuery1.Params.ParamByName('Del_id').asInteger:=strtoint(trim(Del_id[0]));
        SchnipselMainForm.SQLQuery1.ExecSQL;
        SchnipselMainForm.SQLTransaction1.Commit;
        SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_links where exists (select * from schnipsel_names where schnipsel_names.Lang_id=:Del_id and schnipsel_names.id=schnipsel_links.code_id)';
        SchnipselMainForm.SQLQuery1.Params.ParamByName('Del_id').asInteger:=strtoint(trim(Del_id[0]));
        SchnipselMainForm.SQLQuery1.ExecSQL;
        SchnipselMainForm.SQLTransaction1.Commit;
        SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_required where exists (select * from schnipsel_names where schnipsel_names.Lang_id=:Del_id and schnipsel_names.id=schnipsel_required.code_id)';
        SchnipselMainForm.SQLQuery1.Params.ParamByName('Del_id').asInteger:=strtoint(trim(Del_id[0]));
        SchnipselMainForm.SQLQuery1.ExecSQL;
        SchnipselMainForm.SQLTransaction1.Commit;
        SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_comments where exists (select * from schnipsel_names where schnipsel_names.Lang_id=:Del_id and schnipsel_names.id=schnipsel_comments.code_id)';
        SchnipselMainForm.SQLQuery1.Params.ParamByName('Del_id').asInteger:=strtoint(trim(Del_id[0]));
        SchnipselMainForm.SQLQuery1.ExecSQL;
        SchnipselMainForm.SQLTransaction1.Commit;
        SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_codes where exists (select * from schnipsel_names where schnipsel_names.Lang_id=:Del_id and schnipsel_names.id=schnipsel_codes.schnipsel_id)';
        SchnipselMainForm.SQLQuery1.Params.ParamByName('Del_id').asInteger:=strtoint(trim(Del_id[0]));
        SchnipselMainForm.SQLQuery1.ExecSQL;
        SchnipselMainForm.SQLTransaction1.Commit;
        SchnipselMainForm.SQLQuery1.SQL.Text := 'delete from schnipsel_names where Lang_id=:Del_id';
        SchnipselMainForm.SQLQuery1.Params.ParamByName('Del_id').asInteger:=strtoint(trim(Del_id[0]));
        SchnipselMainForm.SQLQuery1.ExecSQL;
        SchnipselMainForm.SQLTransaction1.Commit;
       end;
    except
      on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
    end;
   end;
 end;
end;


procedure TNewCategorieDlg.MoveToListBoxDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var stra : array of string;
begin
 with (Control as Tlistbox) do
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


procedure TNewCategorieDlg.CategorieListEditSelectionChange(Sender: TObject);
var s     : array of string;
    Llang : string;
begin
 s:=CategorieListEdit.Items[CategorieListEdit.ItemIndex].split('->');
 Llang:=trim(s[2]);
 NewCatName1.text:=Llang;
 NewCatShort1.text:=trim(copy(s[0],pos('_',s[0])+1,length(s[0])));
end;


procedure TNewCategorieDlg.CategorieListEditDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var stra : array of string;
begin
 with (Control as Tlistbox) do
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


procedure TNewCategorieDlg.CategorieListDeleteDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var stra : array of string;
begin
 with (Control as Tlistbox) do
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


procedure TNewCategorieDlg.SaveBtn2Click(Sender: TObject);
var stra  : array of string;
    Llang : string;
    Lshort: string;
    Lid     : integer;
    Lid_str : string;
begin
 if (trim(NewCatShort1.text) > '') and (trim(NewCatName1.text) > '') then
  begin
   stra:=CategorieListEdit.Items[CategorieListEdit.ItemIndex].split('_');
   Lid:=strtoint(stra[0]);
   Llang:=trim(NewCatName1.text).replace('_','-',[rfReplaceAll]);
   Lshort:=trim(NewCatShort1.text).replace('_','-',[rfReplaceAll]);
  end;
  if (Llang > '') and (Lshort > '') and (Lid > 0) then
   begin
   try
    SchnipselMainForm.SQLQuery1.SQL.Text := 'update schnipsel_language set Language=:Llang, Lang_short=:Lshort where id=:Lid';
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Llang').asString:=Llang;
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Lshort').asString:=Lshort;
    SchnipselMainForm.SQLQuery1.Params.ParamByName('Lid').asString:=inttostr(Lid);
    SchnipselMainForm.SQLQuery1.ExecSQL;
    SchnipselMainForm.SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
     if (SchnipselMainForm.SQLQuery1.RowsAffected > 0) then
     begin
      lid_str:=inttostr(Lid)+'_'+Lshort+' -> '+Llang;
      CategorieListEdit.Items[CategorieListEdit.ItemIndex]:=Lid_str;
      CategorieListDelete.Items[CategorieListEdit.ItemIndex]:=Lid_str;
      MoveToListBox.Items[CategorieListEdit.ItemIndex]:=Lid_str;
     end;
    end;
end;


procedure TNewCategorieDlg.SaveBtnClick(Sender: TObject);
var s : string;
begin
 if (trim(NewCatShort.text) > '') and (trim(NewCatName.text) > '') then
  begin
   try
    SchnipselMainForm.SQLQuery1.SQL.Text := 'insert into schnipsel_language (Language, Lang_short) values(:NL,:NLS)';
    SchnipselMainForm.SQLQuery1.Params.ParamByName('NL').asString:= trim(NewCatName.text).replace('_','-',[rfReplaceAll]);
    SchnipselMainForm.SQLQuery1.Params.ParamByName('NLS').asString:= trim(NewCatShort.text).replace('_','-',[rfReplaceAll]);
    SchnipselMainForm.SQLQuery1.ExecSQL;
    SchnipselMainForm.SQLTransaction1.Commit;
    if (SchnipselMainForm.SQLQuery1.RowsAffected > 0) then
     begin
      if(SchnipselMainForm.DBEngine='SQLite') then
       SchnipselMainForm.SQLQuery1.SQL.Text := 'SELECT last_insert_rowid() as Last_id from schnipsel_language'
      else
       SchnipselMainForm.SQLQuery1.SQL.Text := 'SELECT LAST_INSERT_ID(Id) as Last_id from schnipsel_language order by LAST_INSERT_ID(Id) desc limit 1;';
      SchnipselMainForm.SQLQuery1.Open;
      s:=SchnipselMainForm.SQLQuery1.FieldByName('Last_id').AsString;
      SchnipselMainForm.SQLQuery1.Close;
      CategorieListEdit.Items.add(s+'_'+trim(NewCatShort.text).replace('_','-',[rfReplaceAll])+' -> '+trim(NewCatName.text).replace('_','-',[rfReplaceAll]));
      CategorieListDelete.Items.add(s+'_'+trim(NewCatShort.text).replace('_','-',[rfReplaceAll])+' -> '+trim(NewCatName.text).replace('_','-',[rfReplaceAll]));
      MoveToListBox.Items.add(s+'_'+trim(NewCatShort.text).replace('_','-',[rfReplaceAll])+' -> '+trim(NewCatName.text).replace('_','-',[rfReplaceAll]));
      NewCatShort.text:='';
      NewCatName.text:='';
     end;
   except
       on E: ESQLDatabaseError do
              messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
    end;
  end;
end;

end.


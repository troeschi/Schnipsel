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
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(SchnipselMainForm.left+(SchnipselMainForm.width/2)),round(SchnipselMainForm.top+(SchnipselMainForm.height/2)));
   end;
   try
    SchnipselMainForm.SQLQuery1.SQL.Text := 'SELECT LAST_INSERT_ID(Id) as Last_id from schnipsel_types order by LAST_INSERT_ID(Id) desc limit 1';
    SchnipselMainForm.SQLQuery1.Open;
    i:=SchnipselMainForm.SQLQuery1.FieldByName('Last_id').AsInteger;
    SchnipselMainForm.SQLQuery1.Close;
   except
    on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(SchnipselMainForm.left+(SchnipselMainForm.width/2)),round(SchnipselMainForm.top+(SchnipselMainForm.height/2)));
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
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(SchnipselMainForm.left+(SchnipselMainForm.width/2)),round(SchnipselMainForm.top+(SchnipselMainForm.height/2)));
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
   msg_ask:=Dlgstr4+fstr+Dlgstr5+tstr+Dlgstr6+fstr+Dlgstr7
  else
   msg_ask:=Dlgstr8+fstr+Dlgstr6+fstr+Dlgstr7;
  if(messageDlgPos(msg_ask,mtConfirmation,
                [mbYes,mbNo],0,round(SchnipselMainForm.left+(SchnipselMainForm.width/2)),round(SchnipselMainForm.top+(SchnipselMainForm.height/2))) = mrYes) then
   begin
    try
     if(from_id <> to_id) then
      begin
       SchnipselMainForm.SQLQuery1.SQL.text:='update schnipsel_names set type_id=:Tid where type_id=:fid';
       SchnipselMainForm.SQLQuery1.Params.ParamByName('Tid').asInteger:=to_id;
      end
     else
      SchnipselMainForm.SQLQuery1.SQL.text:='delete from schnipsel_names where type_id=:fid';
     SchnipselMainForm.SQLQuery1.Params.ParamByName('Fid').asInteger:=from_id;
     SchnipselMainForm.SQLQuery1.ExecSQL;
     SchnipselMainForm.SQLTransaction1.Commit;
    except
     on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(SchnipselMainForm.left+(SchnipselMainForm.width/2)),round(SchnipselMainForm.top+(SchnipselMainForm.height/2)));
    end;
    try
     SchnipselMainForm.SQLQuery1.SQL.text:='delete from schnipsel_types where id=:fid';
     SchnipselMainForm.SQLQuery1.Params.ParamByName('Fid').asInteger:=from_id;
     SchnipselMainForm.SQLQuery1.ExecSQL;
     SchnipselMainForm.SQLTransaction1.Commit;
    except
     on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(SchnipselMainForm.left+(SchnipselMainForm.width/2)),round(SchnipselMainForm.top+(SchnipselMainForm.height/2)));
    end;
    Edittypelistbox.Items.Delete(DeleteListBox.ItemIndex);
    MoveToListBox.Items.Delete(DeleteListBox.ItemIndex);
    DeleteListBox.Items.Delete(DeleteListBox.ItemIndex);
   end;
end;


end.


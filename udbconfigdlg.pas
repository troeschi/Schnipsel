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

// DB-configuration-Form (Window) of the application

unit Udbconfigdlg;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, ComCtrls;

type

  { TDBConfigDlg }

  TDBConfigDlg = class(TForm)
    DBUseBtn: TBitBtn;
    ODBCDlgCancelBtn: TBitBtn;
    ODBCTestBtn: TButton;
    DBInstallBtn: TButton;
    DBBackupBtn: TButton;
    ODBC_DSN_Label: TLabel;
    ODBC_UserName_Edit: TLabeledEdit;
    ODBC_Password_Edit: TLabeledEdit;
    ODBC_Server_Edit: TLabeledEdit;
    ODBC_Port_Edit: TLabeledEdit;
    ODBC_DataBase_Edit: TLabeledEdit;
    ODBC_Charset_Edit: TLabeledEdit;
    ODBC_Driver_Select: TComboBox;
    DatabaseGroupBox: TGroupBox;
    ODBC_Driver_Label: TLabel;
    ODBC_DSN_Select: TComboBox;
    ExportSQLDlg: TSaveDialog;
    OpenSqlDlg: TOpenDialog;
    SQLPbar: TProgressBar;
    procedure DBInstallBtnClick(Sender: TObject);
    procedure DBBackupBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ODBCTestBtnClick(Sender: TObject);
    procedure ODBC_DSN_SelectSelect(Sender: TObject);
  private

  public

  end;


var
  DBConfigDlg: TDBConfigDlg;


implementation

{$R *.lfm}

uses registry, MainForm, SQLDB, DB, Translate_strings, inifiles;


{ TDBConfigDlg }


procedure TDBConfigDlg.DBBackupBtnClick(Sender: TObject);
var NumberOfFields : integer;
    NumberOfRows   : integer;
    ContentList    : TstringList;
    Content        : string;
    TableMakeLine  : string;
    st_counter,
    i,j,z,y        : integer;
    TablesArray    : array of string;
    MemoStream     : Tstream;
    MemoLines      : TstringList;
begin
 if(ExportSQLDlg.execute) then
  begin
   SQLPbar.visible:=true;
   SQLPbar.max:=9;
   SQLPbar.Position:=1;
   TablesArray:=['schnipsel_language','schnipsel_bookmarks','schnipsel_favorites','schnipsel_codes',
                'schnipsel_types','schnipsel_comments','schnipsel_links','schnipsel_required','schnipsel_names'];
   ContentList:=TStringList.create;
   for z:=0 to high(TablesArray) do
    begin
     SQLPbar.Position:=SQLPbar.Position+1;
     SQLPbar.Update;
     sleep(200);
     Content:='';
     ContentList.add('DROP TABLE IF EXISTS `'+TablesArray[z]+'`;');
    try
     SchnipselMainForm.SQLQuery1.SQL.Text := 'Show create table '+TablesArray[z];
     SchnipselMainForm.SQLQuery1.Open;
     while not SchnipselMainForm.SQLQuery1.EOF do
      begin
       TableMakeLine:='';
       for i:=1 to SchnipselMainForm.SQLQuery1.Fields.count-1 do
        TableMakeLine:=TableMakeLine+SchnipselMainForm.SQLQuery1.Fields[i].asString;
       if (Content > '') then
        Content :=  TableMakeLine+';'+slinebreak
       else
        Content:=Content+TableMakeLine+';'+slinebreak;
       SchnipselMainForm.SQLQuery1.next;
      end;
     SchnipselMainForm.SQLQuery1.close;
     ContentList.add(Content);
     SchnipselMainForm.SQLQuery1.SQL.Text:= 'select * from '+TablesArray[z];
     SchnipselMainForm.SQLQuery1.Open;
     NumberOfFields:=SchnipselMainForm.SQLQuery1.fields.count;
     NumberOfRows:=SchnipselMainForm.SQLQuery1.rowsaffected;
     st_counter:=0;
     Content:='';
     for i:=0 to NumberOfFields-1 do
      while not SchnipselMainForm.SQLQuery1.EOF do
       begin
        if (st_counter mod 100 = 0) or ( st_counter = 0 ) then
         begin
          ContentList.add(Content);
          content :='INSERT INTO '+TablesArray[z]+' VALUES';
         end
        else
         Content:='';
        content := content+'(';
        for j:=0 to NumberOfFields-1 do
         begin
          if(SchnipselMainForm.SQLQuery1.Fields[j].asString > '') then
           begin
            if(SchnipselMainForm.SQLQuery1.Fields[j].IsBlob=true) then
             begin
              Contentlist.add(Content);
              Content:='';
              MemoLines:=Tstringlist.create;
              MemoStream:=SchnipselMainForm.sqlquery1.CreateBlobStream(SchnipselMainForm.SQLQuery1.Fields[j],bmread);
              Memolines.LoadFromStream(MemoStream);
              MemoStream.Free;
              for y:=0 to MemoLines.count-1 do
               begin
                if(y=0) then
                 MemoLines[y]:='"'+MemoLines[y].replace('"','\"');
                if(y=MemoLines.count-1) then
                 MemoLines[y]:=MemoLines[y].replace('"','\"')+'"';
                if(y>0) and (y<MemoLines.Count-1) then
                 ContentList.add(MemoLines[y].replace('"','\"'))
                else
                 ContentList.add(MemoLines[y]);
               end;
              MemoLines.free;
             end
            else
             begin
              if(length(Content)+length(SchnipselMainForm.SQLQuery1.Fields[j].asString)>230) then
               begin
                ContentList.add(Content);
                Content:='';
               end;
              content := Content+'"'+SchnipselMainForm.SQLQuery1.Fields[j].asString.replace('"','\"')+'"';
             end;
           end
          else
           content := Content+'""';
          if (j<(NumberOfFields-1)) then
 	   content:= Content+',';
         end;
        content :=Content+')';
        if ((((st_counter+1 mod 100=0) and  (st_counter<>0)) or (st_counter+1=NumberOfRows))) then
         content := Content+';'+slinebreak
        else
         content := Content+',';
        ContentList.add(Content);
        inc(st_counter,1);
        SchnipselMainForm.SQLQuery1.next;
       end;
    except
     on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
    end;
    SchnipselMainForm.SQLQuery1.close;
   end;
  content := slinebreak+slinebreak;
  ContentList.add(Content);
  ContentList.SaveToFile(ExportSQLDlg.FileName);
  ContentList.free;
  SQLPbar.visible:=false;
 end;
end;


procedure TDBConfigDlg.ODBCTestBtnClick(Sender: TObject);
var servstr       : string;
    sqlite_is,
    mysql_is,
    mariadb_is    : boolean;
    schnipsel_ini : TiniFile;
begin
 sqlite_is:=false;
 mysql_is:=false;
 mariadb_is:=false;
 if(SchnipselMainForm.ODBCConnection1.connected=true) then
  begin
   SchnipselMainForm.ODBCConnection1.connected:=false;
   SchnipselMainForm.ODBCConnection1.EndTransaction;
   SchnipselMainForm.ODBCConnection1.close;
  end;
 SchnipselMainForm.ODBCConnection1.Driver:=ODBC_Driver_Select.Items[ODBC_Driver_Select.ItemIndex];
 DBInstallBtn.enabled:=true;
 DBBackupBtn.enabled:=true;
 if(ODBC_DSN_Select.ItemIndex=0) then
  begin
   SchnipselMainForm.ODBCConnection1.DatabaseName:=ODBC_DataBase_Edit.text;
   SchnipselMainForm.ODBCConnection1.UserName:= ODBC_UserName_Edit.text;
   SchnipselMainForm.ODBCConnection1.Password:= ODBC_Password_Edit.text;
   SchnipselMainForm.ODBCConnection1.Params.Clear;
   SchnipselMainForm.ODBCConnection1.Params.Add('server='+ODBC_Server_Edit.text);
   SchnipselMainForm.ODBCConnection1.Params.Add('port='+ODBC_Port_Edit.text);
   SchnipselMainForm.ODBCConnection1.Params.Add('Database='+ODBC_DataBase_Edit.text);
   SchnipselMainForm.ODBCConnection1.Params.Add('Charset='+ODBC_Charset_Edit.text);
  end
 else
  SchnipselMainForm.ODBCConnection1.DatabaseName :=ODBC_DSN_Select.Items[ODBC_DSN_Select.ItemIndex];
 SchnipselMainForm.SQLQuery1.DataBase := SchnipselMainForm.ODBCConnection1;
 SchnipselMainForm.SQLTransaction1.DataBase := SchnipselMainForm.ODBCConnection1;
 SchnipselMainForm.ODBCConnection1.connected:=true;
 try
  SchnipselMainForm.ODBCConnection1.Open;
  if(pos('SQLite',SchnipselMainForm.ODBCConnection1.Driver) > 0) then
   begin
    SchnipselMainForm.SQLQuery1.SQL.Text := 'select sqlite_version()';
    sqlite_is:=true;
    SchnipselMainForm.DBEngine:='SQLite';
   end
  else
   SchnipselMainForm.SQLQuery1.SQL.Text := 'SHOW variables like "%version%"';
  SchnipselMainForm.SQLQuery1.Open;
  if(sqlite_is=false) then
   begin
    servstr:=noDBInfo;
    while not SchnipselMainForm.SQLQuery1.EOF do
     begin
      if(pos('version_comment',SchnipselMainForm.SQLQuery1.Fields[0].AsString)>0) then
       servstr:=SchnipselMainForm.SQLQuery1.Fields[1].AsString+slinebreak;
      if(pos('mysql',lowercase(SchnipselMainForm.SQLQuery1.Fields[1].AsString))>0) then
       begin
        mysql_is:=true;
        SchnipselMainForm.DBEngine:='MySQL';
       end;
      if(pos('mariadb',lowercase(SchnipselMainForm.SQLQuery1.Fields[1].AsString))>0) then
       begin
        mariadb_is:=true;
        SchnipselMainForm.DBEngine:='MariaDB';
       end;
      SchnipselMainForm.SQLQuery1.next;
     end;
   end
  else
   servstr:='SQLite Version '+SchnipselMainForm.SQLQuery1.Fields[0].AsString+slinebreak;
  SchnipselMainForm.SQLQuery1.Close;
  if (mysql_is=true) or (mariadb_is=true) or (sqlite_is=true) then
   messagedlgpos(DBConnectionOK+slinebreak+servstr,mtInformation,[mbOk],0,round(left+(width/2)),round(top+(height/2)))
  else
   begin
    messagedlgpos(DBConnectionFail+slinebreak+servstr,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
    exit;
   end;
  SchnipselMainForm.ODBCConnection1.Transaction := SchnipselMainForm.SQLTransaction1;
  SchnipselMainForm.SQLQuery1.DataBase := SchnipselMainForm.ODBCConnection1;
  SchnipselMainForm.SchnipselIniStorage.save;
 except
  on E: ESQLDatabaseError do
         begin
          messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
          DBInstallBtn.enabled:=false;
          DBBackupBtn.enabled:=false;
         end;
 end;
 try
  schnipsel_ini:=TiniFile.create(sysutils.GetEnvironmentVariable('localappdata')+DirectorySeparator+'Schnipsel'+DirectorySeparator+'Schnipsel.ini');
  schnipsel_ini.WriteBool('DBEngine','SQLite',sqlite_is);
  schnipsel_ini.WriteBool('DBEngine','Mysql',mysql_is);
  schnipsel_ini.WriteBool('DBEngine','MariaDB',mariadb_is);
 finally
  schnipsel_ini.free;
 end;
end;


procedure TDBConfigDlg.ODBC_DSN_SelectSelect(Sender: TObject);
begin
 if((sender as TcomboBox).ItemIndex > 0) then
  begin
   ODBC_UserName_Edit.enabled:=false;
   ODBC_Password_Edit.enabled:=false;
   ODBC_Server_Edit.enabled:=false;
   ODBC_Port_Edit.enabled:=false;
   ODBC_DataBase_Edit.enabled:=false;
   ODBC_Charset_Edit.enabled:=false;
  end
 else
  begin
   ODBC_UserName_Edit.enabled:=true;
   ODBC_Password_Edit.enabled:=true;
   ODBC_Server_Edit.enabled:=true;
   ODBC_Port_Edit.enabled:=true;
   ODBC_DataBase_Edit.enabled:=true;
   ODBC_Charset_Edit.enabled:=true;
  end;
end;


procedure TDBConfigDlg.FormShow(Sender: TObject);
var Registry       : TRegistry;
    ODBCDriverList : TstringList;
    ODBCDSNList    : TStringList;
    i,j            : integer;
begin
 Registry := TRegistry.Create(KEY_READ or KEY_WOW64_64KEY);
 ODBCDriverList:=TstringList.create;
 ODBCDSNList:=TstringList.create;
 ODBC_Driver_Select.clear;
 ODBC_DSN_Select.clear;
 ODBC_UserName_Edit.text:=SchnipselMainForm.ODBCConnection1.UserName;
 ODBC_Password_Edit.text:=SchnipselMainForm.ODBCConnection1.Password;
 for i:=0 to SchnipselMainForm.ODBCConnection1.Params.Count-1 do
  begin
   if(pos('server=',lowercase(SchnipselMainForm.ODBCConnection1.Params[i])) > 0) then
    ODBC_Server_Edit.text:=copy(SchnipselMainForm.ODBCConnection1.Params[i],
                                pos('=',SchnipselMainForm.ODBCConnection1.Params[i])+1,length(SchnipselMainForm.ODBCConnection1.Params[i]));
   if(pos('port=',lowercase(SchnipselMainForm.ODBCConnection1.Params[i])) > 0) then
    ODBC_Port_Edit.text:=copy(SchnipselMainForm.ODBCConnection1.Params[i],
                                pos('=',SchnipselMainForm.ODBCConnection1.Params[i])+1,length(SchnipselMainForm.ODBCConnection1.Params[i]));
   if(pos('database=',lowercase(SchnipselMainForm.ODBCConnection1.Params[i])) > 0) then
    ODBC_DataBase_Edit.text:=copy(SchnipselMainForm.ODBCConnection1.Params[i],
                                pos('=',SchnipselMainForm.ODBCConnection1.Params[i])+1,length(SchnipselMainForm.ODBCConnection1.Params[i]));
   if(pos('charset=',lowercase(SchnipselMainForm.ODBCConnection1.Params[i])) > 0) then
    ODBC_Charset_Edit.text:=copy(SchnipselMainForm.ODBCConnection1.Params[i],
                                pos('=',SchnipselMainForm.ODBCConnection1.Params[i])+1,length(SchnipselMainForm.ODBCConnection1.Params[i]));
  end;
 Registry.RootKey := HKEY_LOCAL_MACHINE;
 if Registry.OpenKeyReadOnly('SOFTWARE\ODBC\ODBCINST.INI\ODBC Drivers') then
  Registry.GetValueNames(ODBCDriverList);
 Registry.CloseKey;
 if Registry.OpenKeyReadOnly('SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources') then
  Registry.GetValueNames(ODBCDSNList);
 Registry.CloseKey;
 if(ODBCDSNList.count=0) then
  begin
   Registry.RootKey:= HKEY_CURRENT_USER;
   if Registry.OpenKeyReadOnly('Software\ODBC\ODBC.INI\ODBC Data Sources') then
    Registry.GetValueNames(ODBCDSNList);
   Registry.CloseKey;
  end;
 Registry.free;
 j:=0;
 if(ODBCDriverList.count=0) then
  begin
   ODBC_Driver_Select.Items.add(NODRVENTRYS);
   inc(j,1);
  end
 else
  for i:=0 to ODBCDriverList.count-1 do
   begin
    ODBC_Driver_Select.Items.add(ODBCDriverList[i]);
    if (ODBCDriverList[i]=SchnipselMainForm.ODBCConnection1.Driver) then
     ODBC_Driver_Select.ItemIndex:=i+j;
   end;
 if (ODBC_Driver_Select.ItemIndex <0) then
  ODBC_Driver_Select.ItemIndex:=0;
 j:=0;
 if(ODBCDSNList.count=0) then
  begin
   ODBC_DSN_Select.Items.add(NODSNENTRYS);
   inc(j,1);
  end
 else
  begin
   ODBC_DSN_Select.Items.add(NOUSEDSN);
   inc(j,1);
   for i:=0 to ODBCDSNList.count-1 do
    begin
     ODBC_DSN_Select.Items.add(ODBCDSNList[i]);
     if (ODBCDSNList[i]=SchnipselMainForm.ODBCConnection1.DataBaseName) then
      ODBC_DSN_Select.ItemIndex:=i+j;
    end;
  end;
 if (ODBC_DSN_Select.ItemIndex <0) then
  ODBC_DSN_Select.ItemIndex:=0;
 ODBCDriverList.free;
 ODBCDSNList.free;
 if(SchnipselMainForm.ODBCConnection1.Connected=false) then
  begin
   DBInstallBtn.enabled:=false;
   DBBackupBtn.enabled:=false;
  end;
 if(ODBC_DSN_Select.ItemIndex > 0) then
  begin
   ODBC_UserName_Edit.enabled:=false;
   ODBC_Password_Edit.enabled:=false;
   ODBC_Server_Edit.enabled:=false;
   ODBC_Port_Edit.enabled:=false;
   ODBC_DataBase_Edit.enabled:=false;
   ODBC_Charset_Edit.enabled:=false;
  end
end;


procedure TDBConfigDlg.DBInstallBtnClick(Sender: TObject);
var ScriptText     : TStringList;
    TranWasStarted : boolean;
begin
 if (MessageDlgPos(RunSqlDump+sLinebreak+RunSqlDump2,mtConfirmation,[mbYes,mbNo],0,left+5,top+100) = mrOK) then
  begin
   Screen.Cursor:=crHourglass;
   TranWasStarted:=SchnipselMainForm.SQLTransaction1.active;
   if not TranWasStarted then SchnipselMainForm.SQLTransaction1.StartTransaction;
   ScriptText:=TStringList.Create;
   ScriptText.LoadFromFile('Templates'+DirectorySeparator+'Schnipsel.sql');
   SchnipselMainForm.SQLScript1.script:=ScriptText;
   try
    SchnipselMainForm.SQLScript1.Execute;
    SchnipselMainForm.SQLTransaction1.Commit;
    ScriptText.Free;
   except
    on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   Screen.Cursor:=crDefault;
  end
 else
  if (OpenSqlDlg.execute) then
   begin
    Screen.Cursor:=crHourglass;
    TranWasStarted:=SchnipselMainForm.SQLTransaction1.active;
    if not TranWasStarted then SchnipselMainForm.SQLTransaction1.StartTransaction;
    ScriptText:=TStringList.Create;
    ScriptText.LoadFromFile(OpenSqlDlg.FileName);
    SchnipselMainForm.SQLScript1.script:=ScriptText;
    try
     SchnipselMainForm.SQLScript1.Execute;
     SchnipselMainForm.SQLTransaction1.Commit;
     ScriptText.Free;
    except
     on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
    end;
    Screen.Cursor:=crDefault;
   end;
end;


end.


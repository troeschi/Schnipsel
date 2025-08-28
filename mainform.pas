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

// Main-Form (Window) of the application

unit MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus, Windows,
  ButtonPanel, ComCtrls, Buttons, StdCtrls, DividerBevel, SynEdit, SynPopupMenu,
  LclType, SynHighlighterAny, LCLTranslator, ECScheme, Languages, Required,
  CodeComment, CodeLinks, NewEntry, CodeTypes, UExportDlg, UExportPDFDlg,
  Translate_strings, TopWindow, UDBConfigDlg, odbcconn, SQLDB, db, Types,
  LCLIntf, IniPropStorage, UniqueInstance, RichMemo, SynEditTypes, PdfDoc,
  PdfTypes, PdfFonts, strUtils, iniFiles, SettingsDlg, DBSearch;



type


  { TSchnipselMainForm }

  TSchnipselMainForm = class(TForm)
    BottomButton_Panel : TButtonPanel;
    CodeDivider: TDividerBevel;
    EditorTB_Author: TEdit;
    EditorTB_Version: TEdit;
    Editor_Code_Name: TEdit;
    Export_ScrollBox: TScrollBox;
    Editor_Toolbar_Images: TImageList;
    FindDlg: TFindDialog;
    CodeLanguages: TMenuItem;
    MainMenuImageList: TImageList;
    SchnipselIniStorage: TIniPropStorage;
    Languages: TMenuItem;
    MemoPopup: TPopupMenu;
    MemoSelectAll: TMenuItem;
    MemoCopy: TMenuItem;
    MemoFav: TMenuItem;
    MemoBookmark: TMenuItem;
    MemoExport: TMenuItem;
    MemoEdit: TMenuItem;
    MemoDelete: TMenuItem;
    MemoDelVer: TMenuItem;
    MemoAddVer: TMenuItem;
    MemoTop: TMenuItem;
    SMSettings: TMenuItem;
    MMnewEntry: TMenuItem;
    MMexportMode: TMenuItem;
    MMeditMode: TMenuItem;
    MMsearch: TMenuItem;
    MMDataBase: TMenuItem;
    Separator1: TMenuItem;
    Separator2: TMenuItem;
    Separator3: TMenuItem;
    Separator4: TMenuItem;
    Separator5: TMenuItem;
    Separator6: TMenuItem;
    Separator7: TMenuItem;
    SQLScript1: TSQLScript;
    Types: TMenuItem;
    Translations: TMenuItem;
    German: TMenuItem;
    English: TMenuItem;
    PopupMainMenu: TPopupMenu;
    PopupSearch1: TMenuItem;
    PopupSearch: TMenuItem;
    PopupReplace: TMenuItem;
    PopupSelectall: TMenuItem;
    PopupSave: TMenuItem;
    PopupEdit: TMenuItem;
    PopupCopy: TMenuItem;
    PopupCut: TMenuItem;
    PopupPaste: TMenuItem;
    Pbar: TProgressBar;
    ReplaceDlg: TReplaceDialog;
    ExportSaveDialog: TSaveDialog;
    ExportasPDFBtn: TButton;
    ExportasHtmlBtn: TButton;
    ExportasXMLBtn: TButton;
    Send_Top_Button: TButton;
    Edit_Required_Button: TButton;
    Edit_Comments_Button: TButton;
    Edit_Links_Button: TButton;
    Comment_Panel: TPanel;
    Links_Panel: TPanel;
    Comments_Codename: TStaticText;
    Links_Codename: TStaticText;
    Export_Panel: TPanel;
    Editor_Panel: TPanel;
    Requires_Panel: TPanel;
    Requires_Codename: TStaticText;
    ImageList_white: TImageList;
    Menu_Entrys : Tstringlist;
    CodeVersion: TStaticText;
    Requires_ScrollBox: TScrollBox;
    Comment_ScrollBox: TScrollBox;
    Links_ScrollBox: TScrollBox;
    Edit_Mode_Button: TSpeedButton;
    CodeEditor: TSynEdit;
    Editor_Toolbar: TToolBar;
    Export_Mode_Button: TSpeedButton;
    CodeAddVerBtn: TSpeedButton;
    CodeFavBtn: TSpeedButton;
    CodeBMBtn: TSpeedButton;
    CodeEditBtn: TSpeedButton;
    CodeExportBtn: TSpeedButton;
    EditorTB_SaveBtn: TToolButton;
    EditorTB_Spacer: TToolButton;
    EditorTB_CopyBtn: TToolButton;
    EditorTB_CutBtn: TToolButton;
    EditorTB_PasteBtn: TToolButton;
    EditorTB_Spacer2: TToolButton;
    NewCodeEntry_Button: TSpeedButton;
    EditorTB_Spacer3: TToolButton;
    CodeEditor_PopupMenu: TSynPopupMenu;
    CodeDeleteBtn: TSpeedButton;
    CodeDelVerBtn: TSpeedButton;
    CodeMemo: TRichMemo;
    ShowSplash_Button: TSpeedButton;
    DBSearch_Button: TSpeedButton;
    Bookmark_Button: TSpeedButton;
    Favorites_Button: TSpeedButton;
    DB_Button: TSpeedButton;
    SynAnySyn1: TSynAnySyn;
    EditorTB_SelectallBtn: TToolButton;
    EDitorTB_SearchBtn: TToolButton;
    EditorTB_ReplaceBtn: TToolButton;
    EditorTB_Spacer4: TToolButton;
    EditorTB_Spacer5: TToolButton;
    EditorTB_Spacer6: TToolButton;
    TypesList   : TStringlist;
    CodesList   : Tstringlist;
    ExportList  : TStringList;
    LTPanel     : TPanel;
    ODBCConnection1: TODBCConnection;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    TopIcon_Panel: TPanel;
    MenuNavi_Panel: TPanel;
    Code_PageControl: TPageControl;
    SideMenu_Panel: TPanel;
    UniqueInstance1: TUniqueInstance;
    WorkSpace_Panel: TPanel;
    MScrollDown: TSpeedButton;
    MScrollUp: TSpeedButton;
    PopupSettingsMenu: TPopupMenu;
    LangTypesList: TScrollBox;
    MainMenu_Button: TSpeedButton;
    Settings_Button: TSpeedButton;
    WorkSpace_StatusBar: TStatusBar;
    Code_TabSheet: TTabSheet;
    Requires_TabSheet: TTabSheet;
    Comment_TabSheet: TTabSheet;
    Links_TabSheet: TTabSheet;

    // Settings Menu
    procedure Settings_ButtonClick(Sender: TObject);
    procedure SMSettingsClick(Sender: TObject);

    // MainMenu Popup
    procedure EnglishClick(Sender: TObject);
    procedure GermanClick(Sender: TObject);
    procedure MenuEditCategoriesClick(Sender: TObject);
    procedure MenuEditTypesClick(Sender: TObject);

    // Left Side Menu
    procedure MenuEntryClick(Sender: TObject);
    procedure MScrollDownClick(Sender: TObject);
    procedure MScrollUpClick(Sender: TObject);

    // WorkSpace Types+Codes
    procedure ShowTypeCodeList(Lang_id : integer);
    procedure CodeEntryClick(Sender: Tobject);
    procedure Expand_ImageClick(Sender: Tobject);
    procedure Delete_ImageClick(Sender: Tobject);

    // WorkSpace Code Display
    Procedure showTopWindow(Sender: TObject);
    Procedure ShowCodeEntry(cid : integer);
    procedure Requires_TabSheetShow(Sender: TObject);
    procedure Comment_TabSheetShow(Sender: TObject);
    procedure Links_TabSheetShow(Sender: TObject);
    procedure LinkTabClick(Sender: TObject);
    procedure CodeAddVerBtnClick(Sender: TObject);
    procedure CodeBMBtnClick(Sender: TObject);
    procedure CodeDeleteBtnClick(Sender: TObject);
    procedure CodeDelVerBtnClick(Sender: TObject);
    procedure CodeEditBtnClick(Sender: TObject);
    procedure CodeExportBtnClick(Sender: TObject);
    procedure CodeFavBtnClick(Sender: TObject);
    Procedure Ver_BtnClick(Sender: Tobject);
    procedure Edit_Comments_ButtonClick(Sender: TObject);
    procedure Edit_Links_ButtonClick(Sender: TObject);
    procedure Edit_Required_ButtonClick(Sender: TObject);
    procedure RcodeEntryClick(Sender : Tobject);
    procedure RcodeLinkClick(Sender : Tobject);
    procedure MemoCopyClick(Sender: TObject);
    procedure CodeMemoMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure MemoSelectAllClick(Sender: TObject);

    //CodeEditor
    procedure EditorTB_CopyBtnClick(Sender: TObject);
    procedure EditorTB_CutBtnClick(Sender: TObject);
    procedure EditorTB_PasteBtnClick(Sender: TObject);
    procedure EditorTB_SaveBtnClick(Sender: TObject);
    procedure EditorTB_SelectallBtnClick(Sender: TObject);
    procedure EDitorTB_SearchBtnClick(Sender: TObject);
    procedure EditorTB_ReplaceBtnClick(Sender: TObject);
    procedure Editor_ToolbarPaint(Sender: TObject);
    procedure FindDlgFind(Sender: TObject);
    procedure ReplaceDlgReplace(Sender: TObject);

    //MainMenu Icons
    procedure DBSearch_ButtonClick(Sender: TObject);
    procedure DB_ButtonClick(Sender: TObject);
    procedure Bookmark_ButtonClick(Sender: TObject);
    procedure Favorites_ButtonClick(Sender: TObject);
    procedure NewCodeEntry_ButtonClick(Sender: TObject);
    procedure Edit_Mode_ButtonClick(Sender: TObject);
    procedure MainMenu_ButtonClick(Sender: TObject);
    procedure Export_Mode_ButtonClick(Sender: TObject);
    procedure ShowSplash_ButtonClick(Sender: TObject);
    procedure NewCodeEntry;

    // MainForm
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject);
    procedure FormWindowStateChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    // Export
    procedure ExportasPDFBtnClick(Sender: TObject);
    procedure ExportasXMLBtnClick(Sender: TObject);
    procedure ExportasHTMLBtnClick(Sender: TObject);
    procedure ExpImgClick(Sender: TObject);

    // Other
    procedure LinkImage(Sender: TObject);
    procedure TextFontLink(Sender: TObject);
    procedure TextFontNormal(Sender: TObject);
    procedure MenuTextLink(Sender: TObject);
    procedure MenuTextNormal(Sender: TObject);
    procedure UsedLnkClick(Sender : Tobject);
    procedure AsyncFree(AData: PtrInt);
    procedure DBSearch_results(searchstr : string);
    procedure HelpButtonClick(Sender: TObject);
    procedure SaveFont(FName: string; Section: string; smFont: TFont);
    procedure LoadFont(FName: string; Section: string; smFont: TFont);
    procedure ShowSplash;

  private

  public
   var Pos_Menu_Top        : Integer;
       Last_Menu_Item      : Integer;
       First_Menu_Item     : Integer;
       Selected_Lang       : Integer;
       Edit_Code_ID        : Integer;
       Selected_Code_ID    : Integer;
       Selected_Version_ID : Integer;
       Expand_Typelist_ID  : string;
       ExpCSS              : string;
       ExpTc               : string;
       ExpUseHeader,
       ExpUseFooter        : Boolean;
       Edit_Mode           : Boolean;
       Export_Mode         : Boolean;
       font_changed        : Boolean;
       DBEngine            : string;
       RBcolor             : string;
  end;


const
  VersionsNr           : string  = '1.0';


var
  SchnipselMainForm    : TSchnipselMainForm;


implementation

{$R *.lfm}


{ TSchnipselMainForm }

procedure TSchnipselMainForm.FormCreate(Sender: TObject);
var i,
    Menu_Set_Pos,
    MEntrys_on_Panel  : integer;
    MEntry            : Tstatictext;
    Mline             : TDividerBevel;
    Split_array       : array of string;
    schnipsel_ini     : TiniFile;
begin
 SchnipselIniStorage.IniFileName:=sysutils.GetEnvironmentVariable('localappdata')+DirectorySeparator+'Schnipsel'+DirectorySeparator+'Schnipsel.ini';
 SchnipselIniStorage.Restore;
 if (not fileexists(sysutils.GetEnvironmentVariable('localappdata')+DirectorySeparator+'Schnipsel'+DirectorySeparator+'Schnipsel.ini') or (ODBCConnection1.Driver='')) then
  begin
   Menu_Entrys:=TStringList.Create;
  end
 else
  begin
   try
    ODBCConnection1.Open;
   except
    on E: ESQLDatabaseError do
          begin
           messagedlg(DataBaseErrorStr+slinebreak+E.Message,mtWarning,[mbOk],0);
           if (SQLQuery1 <> Nil) then
            SQLQuery1.Free;
           if(ODBCConnection1 <> Nil) then
            begin
             ODBCConnection1.Close;
             ODBCConnection1.Free;
            end;
           if(SQLTransaction1 <> Nil) then
            SQLTransaction1.Free;
           close;
           application.terminate;
          end;
   end;
   ODBCConnection1.Transaction := SQLTransaction1;
   SQLQuery1.DataBase := ODBCConnection1;
   Menu_Entrys:=TStringList.Create;
   try
    SQLQuery1.PacketRecords:=-1;
    SQLQuery1.SQL.Text := 'select id,Lang_short from schnipsel_language';
    SQLQuery1.Open;
    while not SQLQuery1.EOF do
     begin
      Menu_Entrys.add(SQLQuery1.FieldByName('Lang_short').AsString+'_'+SQLQuery1.FieldByName('id').AsString);
      SQLQuery1.Next;
     end;
    SQLQuery1.close;
   except
    on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,left+5,top+100);
   end;
  end;
 Pos_Menu_Top:=12;
 Last_Menu_Item:=-1;
 First_Menu_Item:=0;
 Menu_Set_Pos:=Pos_Menu_Top;
 MScrollDown.enabled:=true;
 MEntrys_on_Panel := round(SideMenu_Panel.height / 30);
 if MEntrys_on_Panel > Menu_Entrys.count then
  begin
   MEntrys_on_Panel:= Menu_Entrys.count-1;
   MScrollUp.enabled:=false;
   MScrollDown.enabled:=false;
  end
 else
  begin
   Last_Menu_Item:=MEntrys_on_Panel-1;
   MScrollUp.enabled:=true;
   MScrollDown.enabled:=true;
  end;
 for i:=First_Menu_Item to MEntrys_on_Panel-1 do
  begin
   Split_array:=Menu_Entrys[i].split('_');
   MEntry:=Tstatictext.Create(nil);
   Mentry.Alignment:=taLeftJustify;
   Mentry.Caption:=Split_array[0];
   MEntry.setbounds(12,Menu_Set_Pos,65,17);
   Mentry.onMouseEnter:=@MenuTextLink;
   Mentry.onMouseLeave:=@MenuTextNormal;;
   MEntry.Name:='MEntry_'+Split_array[1];
   Mentry.OnClick:=@MenuEntryClick;
   MEntry.Parent:=SideMenu_Panel;
   Mline:=TDividerBevel.Create(nil);
   Mline.setbounds(8,Menu_Set_Pos+16,64,15);
   Mline.Parent:=SideMenu_Panel;
   inc(Menu_Set_Pos,32);
  end;
 width:=Constraints.MinWidth;
 Edit_Mode:=false;
 Export_Mode:=false;
 Expand_Typelist_ID:='0000000';
 Edit_Code_ID:=0;
 Selected_Code_ID:=0;
 Selected_Version_ID:=0;
 CodesList:=TstringList.create;
 TypesList:=TstringList.create;
 ExportList:=TstringList.create;
 Code_PageControl.visible:=false;
 CodeMemo.Transparent:=true;
 LTPanel:=TPanel.create(nil);
 LTPanel.visible:=true;
 LangTypesList.InsertControl(LTPanel);
 LTPanel.left:=2;
 LTPanel.top:=2;
 LTPanel.Width:=LangTypesList.Width-2;
 LTPanel.Height:=LangTypesList.Height-2;
 LTPanel.Anchors:=LangTypesList.Anchors;
 Editor_Toolbar.enabled:=false;
 EditorTB_Version.enabled:=false;
 EditorTB_Author.enabled:=false;
 LoadFont(sysutils.GetEnvironmentVariable('localappdata')+DirectorySeparator+'Schnipsel'+DirectorySeparator+'Schnipsel.ini','MenuFont',SideMenu_Panel.Font);
 LoadFont(sysutils.GetEnvironmentVariable('localappdata')+DirectorySeparator+'Schnipsel'+DirectorySeparator+'Schnipsel.ini','CodeFont',CodeMemo.Font);
 LoadFont(sysutils.GetEnvironmentVariable('localappdata')+DirectorySeparator+'Schnipsel'+DirectorySeparator+'Schnipsel.ini','ContentFont',Font);
 Code_PageControl.Font.Style:=Font.Style+[fsBold];
 WorkSpace_Panel.Font:=Font;
 Code_TabSheet.font:=Font;
 Requires_TabSheet.font:=Font;
 Comment_TabSheet.font:=Font;
 Links_TabSheet.font:=Font;
 LTPanel.Font:=Font;
 font_changed:=false;
 try
  schnipsel_ini:=TiniFile.create(sysutils.GetEnvironmentVariable('localappdata')+DirectorySeparator+'Schnipsel'+DirectorySeparator+'Schnipsel.ini');
  SetDefaultLang(schnipsel_ini.ReadString('Language','Lang','en'));
  GetLocaleFormatSettings(schnipsel_ini.ReadInteger('Language','Code',$409), DefaultFormatSettings);
  ExpCSS:=schnipsel_ini.ReadString('Export','CSS','Templates'+DirectorySeparator+'Template.css');
  RBcolor:=schnipsel_ini.ReadString('Export','Color','blue');
  ExpTc:=schnipsel_ini.ReadString('Export','TxtColor',colortostring(clWhite));
  ExpUseHeader:=schnipsel_ini.readBool('Export','Header',false);
  ExpUseFooter:=schnipsel_ini.readBool('Export','Footer',false);
  if(Schnipsel_ini.ReadBool('DBEngine','SQLite',false) = true) then
   DBEngine:='SQLite';
  if(Schnipsel_ini.ReadBool('DBEngine','MySQL',false) = true) then
   DBEngine:='MySQL';
  if(Schnipsel_ini.ReadBool('DBEngine','MariaDB',false) = true) then
   DBEngine:='MariaDB';
 finally
  schnipsel_ini.free;
 end;
 showsplash;
end;


procedure TSchnipselMainForm.ShowTopWindow(Sender: TObject);
begin
 TopForm.Font:=Font;
 TopForm.TopCodeMemo.clear;
 TopForm.TopCodeMemo.Font:=CodeMemo.Font;
 TopForm.TopCodeMemo.Lines:=CodeMemo.Lines;
 TopForm.CodeName.caption:=WorkSpace_StatusBar.Panels[1].Text;
 TopForm.Top:=0;
 TopForm.Left:=screen.Desktopwidth-TopForm.width;
 TopForm.width:=530;
 TopForm.height:=450;
 TopForm.show;
end;


procedure TSchnipselMainForm.UsedLnkClick(Sender : Tobject);
begin
 case (Sender as Tstatictext).name of
  'Used1' :  openurl(Used1Lnk);
  'Used2' :  openurl(Used2Lnk);
  'Used3' :  openurl(Used3Lnk);
 end;
end;


procedure TSchnipselMainForm.ShowSplash;
var servstr        : string;
    Tstext         : TStatictext;
    LImage         : TImage;
    DBImage        : Timage;
    Install_Button : Tbutton;
    i              : integer;
begin
 for i:=LTPanel.controlCount-1 downto 0 do
  LTPanel.Controls[i].free;
 LImage:=TImage.create(nil);
 LImage.setbounds(10,15,215,61);
 LImage.picture.loadfromfile('Images'+DirectorySeparator+'Schnipsellogo.png');
 LImage.parent:=LTPanel;
 WorkSpace_StatusBar.Panels[0].Text:=SCHVersion+' '+VersionsNr;
 WorkSpace_StatusBar.Panels[1].Text:=WrittenStr+' '+LicenseStr;
 Tstext:=Tstatictext.create(nil);
 Tstext.setbounds(100,150,300,16);
 Tstext.caption:=Used1Str;
 Tstext.onMouseEnter:=@TextFontLink;
 Tstext.onMouseLeave:=@TextFontNormal;
 Tstext.OnClick:=@UsedLnkClick;
 Tstext.name:='Used1';
 Tstext.alignment:=tacenter;
 Tstext.Parent:=LTPanel;

 Tstext:=Tstatictext.create(nil);
 Tstext.setbounds(100,175,300,16);
 Tstext.caption:=Used2Str;
 Tstext.onMouseEnter:=@TextFontLink;
 Tstext.onMouseLeave:=@TextFontNormal;
 Tstext.OnClick:=@UsedLnkClick;
 Tstext.name:='Used2';
 Tstext.alignment:=tacenter;
 Tstext.Parent:=LTPanel;

 Tstext:=Tstatictext.create(nil);
 Tstext.setbounds(100,200,300,16);
 Tstext.caption:=Used3Str;
 Tstext.onMouseEnter:=@TextFontLink;
 Tstext.onMouseLeave:=@TextFontNormal;
 Tstext.OnClick:=@UsedLnkClick;
 Tstext.name:='Used3';
 Tstext.alignment:=tacenter;
 Tstext.Parent:=LTPanel;
 if(not fileexists(sysutils.GetEnvironmentVariable('localappdata')+DirectorySeparator+'Schnipsel'+DirectorySeparator+'Schnipsel.ini') or (ODBCConnection1.Driver='')) then
  begin
   DBImage:=TImage.create(nil);
   DBImage.setbounds(round((LTPanel.width/2)-40),250,40,40);
   DBImage.picture.loadfromfile('Images'+DirectorySeparator+'DataBase_off.png');
   DBImage.name:='DBImage';
   DBImage.parent:=LTPanel;
   Install_Button:=Tbutton.create(Nil);
   Install_Button.setbounds(180,300,120,30);
   Install_Button.caption:=InstallDBstr;
   Install_Button.Name:='Install_Button';
   Install_Button.onClick:=@DB_ButtonClick;
   Install_Button.Parent:=LTPanel;
  end
 else
  begin
   try
    if(DBEngine = 'SQLite') then
     SQLQuery1.SQL.Text := 'select sqlite_version()'
    else
     SQLQuery1.SQL.Text := 'SHOW variables like "%version%"';
    SQLQuery1.Open;
    servstr:=noDBInfo;
    if(DBEngine = 'SQLite') then
     servstr:='SQLite Version '+SchnipselMainForm.SQLQuery1.Fields[0].AsString+slinebreak;
    while not SchnipselMainForm.SQLQuery1.EOF do
     begin
      if(pos('version_comment',SchnipselMainForm.SQLQuery1.Fields[0].AsString)>0) then
       servstr:=SchnipselMainForm.SQLQuery1.Fields[1].AsString+slinebreak;
      SQLQuery1.next;
     end;
    SQLQuery1.Close;
   except
    on E: ESQLDatabaseError do
        messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   DBImage:=TImage.create(nil);
   DBImage.setbounds(round((LTPanel.width/2)-40),250,40,40);
   DBImage.picture.loadfromfile('Images'+DirectorySeparator+'DataBase_on.png');
   DBImage.name:='DBImage';
   DBImage.parent:=LTPanel;
   Tstext:=Tstatictext.create(nil);
   Tstext.setbounds(100,300,300,16);
   Tstext.caption:=servstr;
   Tstext.alignment:=tacenter;
   Tstext.Parent:=LTPanel;
  end;
 LangTypesList.visible:=true;
end;


procedure TSchnipselMainForm.FormPaint(Sender: TObject);
var i,
    Menu_Set_Pos,
    MEntrys_on_Panel : integer;
    MEntry           : Tstatictext;
    Mline            : TDividerBevel;
    Split_array       : array of string;
begin
 for i:=SideMenu_Panel.ControlCount-1 downto 0 do
  SideMenu_Panel.controls[i].free;
 Pos_Menu_Top:=12;
 MEntrys_on_Panel := round(SideMenu_Panel.height / 30);
 Menu_Set_Pos:=Pos_Menu_Top;
 MScrollDown.enabled:=true;
 if MEntrys_on_Panel > Menu_Entrys.count then
  begin
   MEntrys_on_Panel:= Menu_Entrys.count-1;
   MScrollUp.enabled:=false;
   MScrollDown.enabled:=false;
   MScrollUp.visible:=false;
   MScrollDown.visible:=false;
  end
 else
  begin
   MScrollUp.visible:=true;
   MScrollDown.visible:=true;
   if(First_Menu_Item > 0) then MScrollUp.enabled:=true;
   MScrollDown.enabled:=true;
  end;
 for i:=First_Menu_Item to (First_Menu_Item+MEntrys_on_Panel) do
  if(((Menu_Entrys.count-1) >= i) and (First_Menu_Item >= 0)) then
   begin
    Split_array:=Menu_Entrys[i].split('_');
    MEntry:=Tstatictext.Create(nil);
    Mentry.Alignment:=taLeftJustify;
    MEntry.setbounds(12,Menu_set_Pos,65,17);
    Mentry.Caption:=Split_array[0];
    Mentry.onMouseEnter:=@MenuTextLink;
    Mentry.onMouseLeave:=@MenuTextNormal;;
    MEntry.Name:='MEntry_'+Split_array[1];
    Mentry.OnClick:=@MenuEntryClick;
    Mline:=TDividerBevel.Create(nil);
    Mline.setbounds(8,Menu_set_Pos+16,64,15);
    MEntry.Parent:=SideMenu_Panel;
    Mline.Parent:=SideMenu_Panel;
    inc(Menu_Set_Pos,32);
    if (i > Menu_Entrys.count-1) then
     MScrollDown.enabled:=false;
   end;
 Last_Menu_Item:=i-2;
 if(Last_Menu_Item >= Menu_Entrys.count) then
  MScrollDown.enabled:=false;
 if(First_Menu_Item<=1) then
  MScrollUp.enabled:=false;
end;


procedure TSchnipselMainForm.LinkImage(Sender: TObject);
begin
 (Sender as TImage).Cursor:=crHandPoint;
end;


procedure TSchnipselMainForm.MenuEditTypesClick(Sender: TObject);
var TypesEditList : Tstringlist;
    T_id          : integer;
    Tstr          : string;
begin
 TypesEditList:=TStringList.create;
 try
  SQLQuery1.SQL.Text := 'select id, typename from schnipsel_types';
  SQLQuery1.Open;
  while not SQLQuery1.EOF do
   begin
    T_id:=SQLQuery1.FieldByName('id').AsInteger;
    Tstr:=SQLQuery1.FieldByName('typename').AsString;
    TypesEditList.add(inttostr(T_id)+'_'+tstr);
    SQLQuery1.Next;
   end;
  SQLQuery1.Close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 if (TypesEditList.count > 0) then
  begin
   NewTypeDlg.EditTypeListBox.Items:=TypesEditList;
   NewTypeDlg.EditTypeListBox.ItemIndex:=0;
   NewTypeDlg.DeleteListBox.Items:=TypesEditList;
   NewTypeDlg.DeleteListBox.ItemIndex:=0;
   NewTypeDlg.MoveToListBox.Items:=TypesEditList;
   NewTypeDlg.MoveToListBox.ItemIndex:=0;
  end;
 NewTypeDlg.Font:=Font;
 NewTypeDlg.ShowModal;
 TypesEditList.free;
end;


procedure TSchnipselMainForm.ReplaceDlgReplace(Sender: TObject);
var encon,
    mr       : integer;
    searched : string;
    options  : TSynSearchOptions;
begin
 searched := ReplaceDlg.FindText;
 options := [ssoFindContinue];
 if not(frDown in ReplaceDlg.Options) then options += [ssoBackwards];
 if frMatchCase in ReplaceDlg.Options then options += [ssoMatchCase];
 if frWholeWord in ReplaceDlg.Options then options += [ssoWholeWord];
 if frEntireScope in ReplaceDlg.Options then options += [ssoEntireScope];
 if frReplaceAll in ReplaceDlg.Options then
 begin
  //alles ist zum Austausch bereit
  encon := CodeEditor.SearchReplace(searched,ReplaceDlg.ReplaceText,
  options+[ssoReplaceAll]); //Ersetzt
  MessageDlgPos(Replacestr1 + IntToStr(encon) + Replacestr2,mtInformation,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
  exit;
 end;
 //Ersetzen mit Bestätigung
 ReplaceDlg.CloseDialog;
 encon := CodeEditor.SearchReplace(searched,'',options); //Suche
 while encon <> 0 do
  begin
   mr:=MessageDlgPos(Replacestr3,mtConfirmation,[mbYes,mbNo],0,round(left+(width/2)),round(top+(height/2)));
   if mr = mrNo then exit;
   if mr = mrYES then
    begin
     CodeEditor.TextBetweenPoints[CodeEditor.BlockBegin,CodeEditor.BlockEnd]:=
     ReplaceDlg.ReplaceText;
    end;
   encon := CodeEditor.SearchReplace(searched,'',options); //nächste Suche
  end;
 MessageDlgPos(Replacestr4 + searched,mtInformation,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
end;


procedure TSchnipselMainForm.NewCodeEntry_ButtonClick(Sender: TObject);
begin
 NewCodeEntry;
end;


procedure TSchnipselMainForm.Edit_Required_ButtonClick(Sender: TObject);
var C_id, r_id,i,
    Select_index       : integer;
    Cname, Lname,TName,
    Rname,Rhint,Rurl   : string;
    Req_list           : Tstringlist;
begin
 Codeslist.clear;
 Codeslist.add(Requiredstr1);
 Req_list:=Tstringlist.create;
 Req_list.add(Requiredstr2);
 try
  SQLQuery1.SQL.Text := 'select id, required_name, required_hint, required_link from schnipsel_required where code_id=:cid';
  SQLQuery1.Params.ParamByName('cid').asInteger:=Selected_Code_ID;
  SQLQuery1.Open;
  while not SQLQuery1.EOF do
   begin
    r_id:=SQLQuery1.FieldByName('id').AsInteger;
    Rname:=SQLQuery1.FieldByName('required_name').AsString;
    Rhint:=SQLQuery1.FieldByName('required_hint').AsString;
    Rurl:=SQLQuery1.FieldByName('required_link').AsString;
    Req_list.add(inttostr(r_id)+'_'+Rname+' | '+Rhint+' | '+Rurl);
    SQLQuery1.Next;
   end;
  SQLQuery1.Close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 try
  SQLQuery1.SQL.Text := 'select c.id as Cid, c.schnipsel_name as Cname, l.language as Lname, t.TypeName as Tname from schnipsel_names as c, schnipsel_language as l, schnipsel_types as t where c.type_id=t.id and c.lang_id=l.id';
  SQLQuery1.Open;
  while not SQLQuery1.EOF do
   begin
    C_id:=SQLQuery1.FieldByName('Cid').AsInteger;
    Cname:=SQLQuery1.FieldByName('Cname').AsString;
    Lname:=SQLQuery1.FieldByName('Lname').AsString;
    Tname:=SQLQuery1.FieldByName('Tname').AsString;
    Codeslist.add(inttostr(C_id)+'_'+Lname+' -> '+Tname+' -> '+Cname);
    if Selected_Code_Id=C_id then
     Select_index:=Codeslist.count-1;
    SQLQuery1.Next;
   end;
  SQLQuery1.Close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 RequiredDlg.RfC_Select.Items:=Codeslist;
 RequiredDlg.RfC_Select1.Items:=Codeslist;
 RequiredDlg.RfC_Select.ItemIndex:=Select_index;
 RequiredDlg.RfC_Select1.ItemIndex:=Select_index;
 RequiredDlg.RfC_Select.enabled:=false;
 RequiredDlg.RfC_Select1.enabled:=false;
 RequiredDlg.Code_inBase.Items:=Codeslist;
 RequiredDlg.Code_inBase1.Items:=Codeslist;
 RequiredDlg.Code_inBase.ItemIndex:=0;
 RequiredDlg.Code_inBase1.ItemIndex:=0;
 RequiredDlg.ReqEdit_Select.Items:=Req_list;
 RequiredDlg.ReqEdit_Select.ItemIndex:=0;
 Req_list.free;
 RequiredDlg.Font:=Font;
 RequiredDlg.ShowModal;
 for i:=Requires_Panel.ControlCount-1 downto 0 do
  Requires_Panel.Controls[i].free;
 Requires_TabSheetShow(nil);
end;


procedure TSchnipselMainForm.Export_Mode_ButtonClick(Sender: TObject);
begin
 if (Export_Mode=true) then
  begin
   Export_Mode:=false;
   CodeExportBtn.visible:=false;
   Export_Panel.visible:=false;
   ExportasHtmlBtn.visible:=false;
   ExportasXMLBtn.visible:=false;
   ExportasPDFBtn.visible:=false;
   Export_Mode_Button.ImageIndex:=21;
   if(width<screen.Desktopwidth) then
    begin
     width:=width-Export_Panel.width;
     left:=left+round(Export_Panel.width/2);
    end
   else
    width:=screen.Desktopwidth;
  end
 else
 begin
  Export_Mode:=true;
  CodeExportBtn.visible:=true;
  Export_Panel.visible:=true;
  ExportasHtmlBtn.visible:=true;
  ExportasXMLBtn.visible:=true;
  ExportasPDFBtn.visible:=true;
  Export_Mode_Button.ImageIndex:=22;
  if(width<>screen.Desktopwidth) then
   begin
    if((width+Export_Panel.width+5) <= screen.Desktopwidth) then
     width:=width+Export_Panel.width+5
    else
     width:=screen.DesktopWidth;
   end;
 end;
end;


procedure TSchnipselMainForm.FindDlgFind(Sender: TObject);
var  encon    : integer;
     searched : string;
     options  : TSynSearchOptions;
begin
 searched := FindDlg.FindText;
 options := [];
 if not(frDown in FindDlg.Options) then options += [ssoBackwards];
 if frMatchCase in FindDlg.Options then options += [ssoMatchCase];
 if frWholeWord in FindDlg.Options then options += [ssoWholeWord];
 if frEntireScope in FindDlg.Options then options += [ssoEntireScope];
 encon := CodeEditor.SearchReplace(searched,'',options);
end;


procedure TSchnipselMainForm.Edit_Comments_ButtonClick(Sender: TObject);
var C_id, Co_id,i,
    Select_index : integer;
    Cname, Lname,TName,
    CAuthor,Ccomment   : string;
    Com_list           : Tstringlist;
begin
 Codeslist.clear;
 Com_list:=Tstringlist.create;
 Com_list.add(Requiredstr2);
 try
  SQLQuery1.SQL.Text := 'select id, author, comment from schnipsel_comments where code_id=:cid';
  SQLQuery1.Params.ParamByName('cid').asInteger:=Selected_Code_ID;
  SQLQuery1.Open;
  while not SQLQuery1.EOF do
   begin
    Co_id:=SQLQuery1.FieldByName('id').AsInteger;
    CAuthor:=SQLQuery1.FieldByName('author').AsString;
    Ccomment:=SQLQuery1.FieldByName('comment').AsString;
    Com_list.add(inttostr(Co_id)+'_'+CAuthor+' | '+Ccomment);
    SQLQuery1.Next;
   end;
  SQLQuery1.Close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 try
  SQLQuery1.SQL.Text := 'select c.id as Cid, c.schnipsel_name as Cname, l.language as Lname, t.TypeName as Tname from schnipsel_names as c, schnipsel_language as l, schnipsel_types as t where c.type_id=t.id and c.lang_id=l.id';
  SQLQuery1.Open;
  while not SQLQuery1.EOF do
   begin
    C_id:=SQLQuery1.FieldByName('Cid').AsInteger;
    Cname:=SQLQuery1.FieldByName('Cname').AsString;
    Lname:=SQLQuery1.FieldByName('Lname').AsString;
    Tname:=SQLQuery1.FieldByName('Tname').AsString;
    Codeslist.add(inttostr(C_id)+'_'+Lname+' | '+Tname+' -> '+Cname);
    if Selected_Code_Id=C_id then
     Select_index:=Codeslist.count-1;
    SQLQuery1.Next;
   end;
  SQLQuery1.Close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 CommentDlg.CfC_Select.Items:=Codeslist;
 CommentDlg.CfC_Select1.Items:=Codeslist;
 CommentDlg.CfC_Select.ItemIndex:=Select_index;
 CommentDlg.CfC_Select1.ItemIndex:=Select_index;
 CommentDlg.CfC_Select.enabled:=false;
 CommentDlg.CfC_Select1.enabled:=false;
 CommentDlg.EditCom_Select.Items:=Com_list;
 CommentDlg.EditCom_Select.ItemIndex:=0;
 Com_list.free;
 CommentDlg.Font:=Font;
 CommentDlg.ShowModal;
 for i:=Comment_Panel.ControlCount-1 downto 0 do
  Comment_Panel.Controls[i].free;
 Comment_TabSheetShow(nil);
end;


procedure TSchnipselMainForm.CodeEditBtnClick(Sender: TObject);
begin
 if(Edit_Mode=false) then
  begin
   Edit_Mode:=true;
   Edit_Comments_Button.visible:=true;
   Edit_Links_Button.visible:=true;
   Edit_Required_Button.visible:=true;
   Edit_Mode_Button.ImageIndex:=23;
   Editor_Panel.visible:=true;
   width:=width+471;
   if(width > screen.Desktopwidth) then
    width:=screen.Desktopwidth;
   end;
 try
  SQLQuery1.SQL.Text := 'SELECT c.version as version,c.author as author,n.schnipsel_name as name from schnipsel_codes as c join schnipsel_names as n on c.schnipsel_id=n.id and c.id=:Code_id';
  SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Version_ID;
  SQLQuery1.Open;
  EditorTB_Version.text:=SQLQuery1.FieldByName('version').Asstring;
  EditorTB_Author.text:=SQLQuery1.FieldByName('author').Asstring;
  Editor_Code_Name.Text:=SQLQuery1.FieldByName('name').Asstring;
  SQLQuery1.Close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 Editor_Toolbar.enabled:=true;
 Editor_Code_Name.Enabled:=true;
 EditorTB_Author.enabled:=true;
 EditorTB_Version.Enabled:=true;
 if((Edit_Code_ID > 0) or (CodeEditor.enabled=true)) then
  if(messageDlgPos(Editorstr7+slinebreak+Editorstr8,mtConfirmation,[mbYes,mbNo],0,
                   round(left+(width/2)),round(top+(height/2))) = mrNo) then
   exit
  else
   Edit_Code_ID:=0;
 CodeEditor.enabled:=true;
 CodeEditor.Clear;
 CodeEditor.Lines:=CodeMemo.Lines;
 CodeEditor.SetFocus;
 CodeEditor.CaretX:=1;
 CodeEditor.CaretY:=1;
end;


procedure TSchnipselMainForm.ExpImgClick(Sender: TObject);
var stra : array of string;
    i,j  : integer;
begin
 if(messageDlgPos(Exportstr1,mtConfirmation,[mbYes,mbNo],0,round(left+(width/2)),round(top+(height/2))) = mrYes) then
  begin
   stra:=(Sender as TImage).name.split('_');
   i:=strtoint(stra[1]);
   for j:=Export_Scrollbox.controlcount-1 downto 0 do
    if (Export_Scrollbox.controls[j].name='ExpImage_delete') then
     Export_Scrollbox.controls[j].free;
   if(i < Exportlist.count-1) then
    begin
     Exportlist.Exchange(i,Exportlist.count-1);
     Export_Scrollbox.controls[i].hint:=Export_Scrollbox.controls[Exportlist.count-1].hint;
     Export_Scrollbox.controls[Exportlist.count-1].free;
     Exportlist.delete(Exportlist.count-1);
     Export_Scrollbox.controls[i].name:='ExpImage_'+inttostr(i);
    end
   else
    begin
     Exportlist.Delete(i);
     (Sender as TImage).visible:=false;
     (Sender as TImage).name:='ExpImage_delete';
    end;
  end;
end;


procedure TSchnipselMainForm.CodeExportBtnClick(Sender: TObject);
var s,
    hs       : string;
    i,j,
    imgLeft,
    ImgTop   : integer;
    ExpImg   : TImage;
    DelFound : Boolean;
    stra     : array of string;
begin
 ExportDlg.CodeName.caption:=WorkSpace_StatusBar.Panels[1].text;
 if(ExportList.Count >= 50) then
  if(messageDlgPos(Exportstr23,mtConfirmation,[mbYes,mbNo],0,round(left+(width/2)),round(top+(height/2))) <> mrYes) then
   exit;
 if (ExportDlg.showmodal = mrOk) then
  begin
   hs:=Exportstr2+WorkSpace_StatusBar.Panels[1].text+slinebreak;
   s:=inttostr(Selected_Version_ID)+'_';
   for i:=0 to ExportList.count-1 do
    begin
     stra:=ExportList[i].split('_');
     if(strtoint(stra[0]) = Selected_Version_ID) then
      begin
       messageDlgPos(Exportstr3,mtInformation,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
       exit;
      end;
    end;
   if(ExportDlg.ExportRequired.checked=true) then
    begin
     s:=s+'1_';
     hs:=hs+Exportstr4;
    end
   else
    s:=s+'0_';
   if(ExportDlg.ExportComments.checked=true) then
    begin
     s:=s+'1_';
     hs:=hs+ Exportstr5;
    end
   else
    s:=s+'0_';
   if(ExportDlg.ExportLinks.checked=true) then
    begin
     s:=s+'1_';
     hs:=hs+ Exportstr6;
    end
   else
    s:=s+'0_';
   s:=s+WorkSpace_StatusBar.Panels[1].text;
   if(ExportList.Count mod 2=0) then
    Imgleft:=24
   else
    ImgLeft:=72;
   ImgTop:=16;
   for j:=1 to Exportlist.count do
    if(j mod 2=0) then
     inc(ImgTop,46);
   Exportlist.add(s);
   ExpImg:=TImage.Create(nil);
   ExpImg.setbounds(ImgLeft,ImgTop,30,30);
   ExpImg.showhint:=true;
   ExpImg.hint:=hs;
   ExpImg.name:='ExpImage_'+inttostr(Exportlist.count-1);
   ExpImg.OnClick:=@ExpImgClick;
   ExpImg.picture.loadfromfile('Images'+DirectorySeparator+'rss_cover.png');
   ExpImg.Parent:=Export_Scrollbox;
   DelFound:=false;
   for i:=Export_ScrollBox.ControlCount-1 downto 0 do
    begin
     if(Export_ScrollBox.Controls[i].visible=false) then
      Export_ScrollBox.Controls[i].free;
      DelFound:=true;
    end;
   if(DelFound=true) then
    begin
     ImgTop:=-30;
     for i:=0 to Export_Scrollbox.ControlCount-1 do
      begin
       if(i mod 2=0) then
        begin
         inc(ImgTop,46);
         ImgLeft:=24;
        end
       else
        ImgLeft:=72;
       Export_Scrollbox.Controls[i].left:=ImgLeft;
       Export_Scrollbox.Controls[i].top:=ImgTop;
      end;
    end;
  end;
end;


procedure TSchnipselMainForm.CodeFavBtnClick(Sender: TObject);
begin
 if((Sender as TSpeedButton).ImageIndex=28) then
  begin
   SQLQuery1.SQL.text:='insert into schnipsel_favorites (schnipsel_id) values(:Code_id)';
   (Sender as TSpeedButton).ImageIndex:=29;
   (Sender as TSpeedButton).hint:=Centrystr7;
  end
 else
  begin
   SQLQuery1.SQL.text:='delete from schnipsel_favorites where schnipsel_id=:Code_id';
   (Sender as TSpeedButton).ImageIndex:=28;
   (Sender as TSpeedButton).hint:=Centrystr6;
  end;
 try
  SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
  SQLQuery1.ExecSQL;
  SQLTransaction1.Commit;
 except
  on E: ESQLDatabaseError do
        messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 (Sender as TSpeedButton).RePaint;
end;


procedure TSchnipselMainForm.SMSettingsClick(Sender: TObject);
begin
end;


procedure TSchnipselMainForm.Settings_ButtonClick(Sender: TObject);
var schnipsel_ini : TiniFile;
    i             : integer;
    s             : string;
begin
 SettingsDialog.DefaultSample.Font:=Font;
 SettingsDialog.MenuSample.Font:=SideMenu_Panel.Font;
 SettingsDialog.CodeSample.Font:=CodeMemo.Font;
 if(SettingsDialog.showModal=mrOk) then
  begin
   ExpTc:=colortostring(SettingsDialog.TXTcolor.Brush.Color);
   RBcolor:='blue';
   if(SettingsDialog.RBblue.checked=true) then
    RBcolor:='blue';
   if(SettingsDialog.RBred.checked=true) then
    RBcolor:='red';
   if(SettingsDialog.RBgreen.checked=true) then
    RBcolor:='green';
   if(SettingsDialog.RBbrown.checked=true) then
    RBcolor:='brown';
   s:='Templates'+DirectorySeparator+'Template.css';
   for i:=0 to SettingsDialog.Scrollbox1.ControlCount-1 do
    if(SettingsDialog.Scrollbox1.Controls[i] is TRadioButton) then
     if((SettingsDialog.Scrollbox1.Controls[i] as TRadioButton).checked=true) then
      s:=SettingsDialog.Scrollbox1.Controls[i].Caption;
   schnipsel_ini:=TiniFile.create(sysutils.GetEnvironmentVariable('localappdata')+DirectorySeparator+'Schnipsel'+DirectorySeparator+'Schnipsel.ini');
   try
    schnipsel_ini.WriteString('Export','Color',Rbcolor);
    schnipsel_ini.WriteString('Export','CSS',s);
    schnipsel_ini.WriteString('Export','TxtColor',ExpTc);
    schnipsel_ini.writeBool('Export','Header',SettingsDialog.UseHeader.Checked);
    schnipsel_ini.writeBool('Export','Footer',SettingsDialog.UseFooter.Checked);
   finally
    schnipsel_ini.free;
   end;
   ExpCSS:=s;
   ExpUseHeader:=SettingsDialog.UseHeader.Checked;
   ExpUseFooter:=SettingsDialog.UseFooter.Checked;
   Font:=SettingsDialog.DefaultSample.font;
   SideMenu_Panel.Font:=SettingsDialog.MenuSample.font;
   LTPanel.Font:=SettingsDialog.DefaultSample.font;
   WorkSpace_Panel.Font:=SettingsDialog.DefaultSample.font;
   CodeMemo.Font:=SettingsDialog.CodeSample.font;
   Code_TabSheet.font:=SettingsDialog.DefaultSample.font;
   Requires_TabSheet.font:=SettingsDialog.DefaultSample.font;
   Comment_TabSheet.font:=SettingsDialog.DefaultSample.font;
   Links_TabSheet.font:=SettingsDialog.DefaultSample.font;
   font_changed:=true;
  end;
end;


procedure TSchnipselMainForm.CodeMemoMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled : Boolean);
var key : word;
begin
 if (WheelDelta > 0) then
  key:=VK_Prior
 else
  Key:=VK_Next;
 Handled:=True;
 PostMessage(CodeMemo.Handle, WM_KEYDOWN, Key, 0);
end;


procedure TSchnipselMainForm.EditorTB_CopyBtnClick(Sender: TObject);
begin
 if (CodeEditor.selavail=true) then
  CodeEditor.CopyToClipboard;
end;


procedure TSchnipselMainForm.EditorTB_CutBtnClick(Sender: TObject);
begin
 if (CodeEditor.selavail=true) then
  CodeEditor.CutToClipboard;
end;


procedure TSchnipselMainForm.EditorTB_PasteBtnClick(Sender: TObject);
begin
 if(CodeEditor.CanPaste=true) then
  CodeEditor.PasteFromClipboard;
end;


procedure TSchnipselMainForm.EditorTB_SaveBtnClick(Sender: TObject);
var EditorStream : TMemoryStream;
    i            : integer;
begin
 if(CodeEditor.lines.Count > 1000) then
  begin
   messageDlgPos(Editorstr5+slinebreak+Editorstr6,mtWarning,[mbOK],0,round(left+(width/2)),round(top+(height/2)));
   for i:=CodeEditor.Lines.Count-1 downto 1000 do
    CodeEditor.Lines.Delete(i);
  end;
 if(Editor_Toolbar.enabled=true) then
 begin
 if(Edit_Code_ID=0) then
  begin
   try
    SQLQuery1.SQL.Text := 'update schnipsel_names set Schnipsel_Name=:Cname where id=:Code_id';
    SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
    SQLQuery1.Params.ParamByName('Cname').asString:=trim(Editor_Code_Name.text);
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
          messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   try
    if (Selected_Version_ID > 0) then         // Code Version Update
     begin
      SQLQuery1.SQL.Text := 'update schnipsel_codes set schnipsel_id=:Code_id, author=:Author, version=:Version,schnipsel=:Schnipsel where id=:To_id';
      SQLQuery1.Params.ParamByName('To_id').asInteger:=Selected_Version_ID;
     end
    else                                      // Code New Version
     SQLQuery1.SQL.Text := 'insert into schnipsel_codes (schnipsel_id,author,version,schnipsel) values(:Code_id,:Author,:Version,:Schnipsel)';
    SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
    SQLQuery1.Params.ParamByName('Version').asString:=trim(EditorTB_Version.text);
    SQLQuery1.Params.ParamByName('Author').asString:=trim(EditorTB_Author.text);
    EditorStream:=TMemoryStream.create;
    CodeEditor.lines.SaveToStream(EditorStream);
    SQLQuery1.ParamByName('Schnipsel').LoadFromStream(EditorStream, ftBlob);
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
    EditorStream.Free;
   except
    on E: ESQLDatabaseError do
          messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   i:=0;
   if(Selected_Version_ID=0) then             // New Code Version, WE NEED THE ID
    begin
     try
      if(DBEngine='SQLite') then
       SQLQuery1.SQL.Text := 'SELECT last_insert_rowid() as Last_id from schnipsel_codes'
      else
       SQLQuery1.SQL.Text := 'SELECT LAST_INSERT_ID(Id) as Last_id from schnipsel_codes order by LAST_INSERT_ID(Id) desc limit 1';
      SQLQuery1.Open;
      i:=SQLQuery1.FieldByName('Last_id').AsInteger;
      SQLQuery1.Close;
     except
       on E: ESQLDatabaseError do
             messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
     end;
    end;
   if(i>0) then
    Selected_Version_ID:=i;
  end;
 if(Edit_Code_ID > 0) then         // New CodeEntry
  begin
   try
    SQLQuery1.SQL.Text := 'insert into schnipsel_codes (schnipsel_id,author,version,schnipsel) values(:Code_id,:Author,:Version,:Schnipsel)';
    SQLQuery1.Params.ParamByName('Code_id').asInteger:=Edit_Code_ID;
    SQLQuery1.Params.ParamByName('Version').asString:=trim(EditorTB_Version.text);
    SQLQuery1.Params.ParamByName('Author').asString:=trim(EditorTB_Author.text);
    EditorStream:=TMemoryStream.create;
    CodeEditor.lines.SaveToStream(EditorStream);
    SQLQuery1.ParamByName('Schnipsel').LoadFromStream(EditorStream, ftBlob);
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
    EditorStream.Free;
   except
    on E: ESQLDatabaseError do
          messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   try
    if(DBEngine='SQLite') then
     SQLQuery1.SQL.Text := 'SELECT last_insert_rowid() as Last_id from schnipsel_codes'
    else
     SQLQuery1.SQL.Text := 'SELECT LAST_INSERT_ID(Id) as Last_id from schnipsel_codes order by LAST_INSERT_ID(Id) desc limit 1';
    SQLQuery1.Open;
    i:=SQLQuery1.FieldByName('Last_id').AsInteger;
    SQLQuery1.Close;
    except
     on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   Selected_Code_ID:=Edit_Code_ID;
   Selected_Version_ID:=i;
   try
    SQLQuery1.SQL.Text := 'update schnipsel_names set Schnipsel_Name=:Cname where id=:Code_id';
    SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
    SQLQuery1.Params.ParamByName('Cname').asString:=trim(Editor_Code_Name.text);
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
          messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   Edit_Code_ID:=0;
  end;
 CodeEditor.clear;
 EditorTB_Version.text:='';
 EditorTB_Author.text:='';
 Editor_Code_Name.text:='';
 Editor_Toolbar.enabled:=false;
 CodeEditor.Enabled:=false;
 EditorTB_Author.enabled:=false;
 EditorTB_Version.Enabled:=false;
 Editor_Code_Name.Enabled:=false;
 showCodeEntry(Selected_Version_ID);
 end;
end;


procedure TSchnipselMainForm.Editor_ToolbarPaint(Sender: TObject);
var i : integer;
begin
 i:=(Sender as TToolbar).width-5;
 EditorTB_Author.width:=i-EditorTB_Author.left;
end;


procedure TSchnipselMainForm.CodeAddVerBtnClick(Sender: TObject);
begin
 if(Edit_Mode=false) then
  begin
   Edit_Mode:=true;
   Edit_Comments_Button.visible:=true;
   Edit_Links_Button.visible:=true;
   Edit_Required_Button.visible:=true;
   Edit_Mode_Button.ImageIndex:=23;
   Editor_Panel.visible:=true;
   width:=width+471;
   if(width > screen.Desktopwidth) then
    width:=screen.Desktopwidth;
  end;
 if((Edit_Code_ID > 0) or (CodeEditor.enabled=true)) then
  if(messageDlgPos(Editorstr7+slinebreak+Editorstr9,mtConfirmation,[mbYes,mbNo],0,
                   round(left+(width/2)),round(top+(height/2))) = mrNo) then
   exit
  else
   Edit_Code_ID:=0;
 Editor_Toolbar.enabled:=true;
 CodeEditor.enabled:=true;
 Editor_Code_Name.Text:=WorkSpace_StatusBar.Panels[1].text;
 EditorTB_Version.Text:=Editorstr1 ;
 EditorTB_Author.Text:=Editorstr2 ;
 EditorTB_Version.enabled:=true ;
 EditorTB_Author.enabled:=true;
 Selected_Version_ID:=0;
 CodeEditor.Clear;
 CodeEditor.SetFocus;
end;


procedure TSchnipselMainForm.CodeBMBtnClick(Sender: TObject);
begin
 if((Sender as TSpeedButton).ImageIndex=26) then
  begin
   SQLQuery1.SQL.text:='insert into schnipsel_bookmarks (schnipsel_id) values(:Code_id)';
   (Sender as TSpeedButton).ImageIndex:=27;
   (Sender as TSpeedButton).hint:=Centrystr5;
  end
 else
  begin
   SQLQuery1.SQL.text:='delete from schnipsel_bookmarks where schnipsel_id=:Code_id';
   (Sender as TSpeedButton).ImageIndex:=26;
   (Sender as TSpeedButton).hint:=Centrystr4;
  end;
 try
  SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
  SQLQuery1.ExecSQL;
  SQLTransaction1.Commit;
 except
  on E: ESQLDatabaseError do
        messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 (Sender as TSpeedButton).RePaint;
end;


procedure TSchnipselMainForm.CodeDeleteBtnClick(Sender: TObject);
begin
 if(MessageDlgPos(Typeliststr3,mtconfirmation,
                   [mbYes,mbNo],0,round(left+(width/2)),round(top+(height/2))) = mrYes) then
  begin
   try
    SQLQuery1.SQL.Text := 'delete from schnipsel_favorites where schnipsel_id=:Code_id';
    SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
          messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   try
    SQLQuery1.SQL.Text := 'delete from schnipsel_bookmarks where schnipsel_id=:Code_id';
    SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
          messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   try
    SQLQuery1.SQL.Text := 'delete from schnipsel_required where required_id=:Code_id';
    SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
   except
     on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   try
    SQLQuery1.SQL.Text := 'delete from schnipsel_codes where schnipsel_id=:Code_id';
    SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
          messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   try
    SQLQuery1.SQL.Text := 'delete from schnipsel_names where id=:Code_id';
    SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
          messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   Selected_Code_ID:=0;
   Selected_Version_ID:=0;
   ShowTypeCodeList(Selected_Lang);
  end;
end;


procedure TSchnipselMainForm.CodeDelVerBtnClick(Sender: TObject);
var i : integer;
begin
 if(MessageDlgPos(Typeliststr4,mtconfirmation,
                   [mbYes,mbNo],0,round(left+(width/2)),round(top+(height/2))) = mrYes) then
  begin
   i:=0;
   try
    SQLQuery1.SQL.Text := 'delete from schnipsel_codes where id=:Code_id';
    SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Version_ID;
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
          messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   try
    SQLQuery1.SQL.Text := 'SELECT id as C_id from schnipsel_codes where schnipsel_id=:Code_id order by id DESC limit 1';
    SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
    SQLQuery1.Open;
    if(SQLQuery1.RowsAffected > 0) then
     i:=SQLQuery1.FieldByName('C_id').AsInteger;
    SchnipselMainForm.SQLQuery1.Close;
   except
    on E: ESQLDatabaseError do
          messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   if(i > 0) then
    begin
     Selected_Version_ID:=i;
     showCodeEntry(i);
    end
   else
    begin
     try
      SQLQuery1.SQL.Text := 'delete from schnipsel_names where id=:Code_id';
      SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
      SQLQuery1.ExecSQL;
      SQLTransaction1.Commit;
     except
      on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
     end;
     try
      SQLQuery1.SQL.Text := 'delete from schnipsel_required where required_id=:Code_id';
      SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
      SQLQuery1.ExecSQL;
      SQLTransaction1.Commit;
     except
      on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
     end;
     try
      SQLQuery1.SQL.Text := 'delete from schnipsel_favorites where schnipsel_id=:Code_id';
      SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
      SQLQuery1.ExecSQL;
      SQLTransaction1.Commit;
     except
      on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
     end;
     try
      SQLQuery1.SQL.Text := 'delete from schnipsel_bookmarks where schnipsel_id=:Code_id';
      SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
      SQLQuery1.ExecSQL;
      SQLTransaction1.Commit;
     except
      on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
     end;
     Selected_Code_ID:=0;
     Selected_Version_ID:=0;
     ShowTypeCodeList(Selected_Lang);
    end;
  end;
end;


procedure TSchnipselMainForm.Edit_Links_ButtonClick(Sender: TObject);
var C_id, Lnk_id,i,
    Select_index : integer;
    Cname, Lname,TName,
    Lnkname,Lnkurl     : string;
    Lnk_list           : Tstringlist;
begin
 Codeslist.clear;
 Lnk_list:=Tstringlist.create;
 Lnk_list.add(Requiredstr2);
 try
  SQLQuery1.SQL.Text := 'select id, Link_text, Link_url from schnipsel_links where code_id=:cid';
  SQLQuery1.Params.ParamByName('cid').asInteger:=Selected_Code_ID;
  SQLQuery1.Open;
  while not SQLQuery1.EOF do
   begin
    Lnk_id:=SQLQuery1.FieldByName('id').AsInteger;
    Lnkname:=SQLQuery1.FieldByName('Link_text').AsString;
    Lnkurl:=SQLQuery1.FieldByName('Link_url').AsString;
    Lnk_list.add(inttostr(Lnk_id)+'_'+Lnkname+' | '+Lnkurl);
    SQLQuery1.Next;
   end;
  SQLQuery1.Close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 try
  SQLQuery1.SQL.Text := 'select c.id as Cid, c.schnipsel_name as Cname, l.language as Lname, t.TypeName as Tname from schnipsel_names as c, schnipsel_language as l, schnipsel_types as t where c.type_id=t.id and c.lang_id=l.id';
  SQLQuery1.Open;
  while not SQLQuery1.EOF do
   begin
    C_id:=SQLQuery1.FieldByName('Cid').AsInteger;
    Cname:=SQLQuery1.FieldByName('Cname').AsString;
    Lname:=SQLQuery1.FieldByName('Lname').AsString;
    Tname:=SQLQuery1.FieldByName('Tname').AsString;
    Codeslist.add(inttostr(C_id)+'_'+Lname+' -> '+Tname+' -> '+Cname);
    if Selected_Code_Id=C_id then
     Select_index:=Codeslist.count-1;
    SQLQuery1.Next;
   end;
  SQLQuery1.Close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 LinkDlg.LfC_Select.Items:=Codeslist;
 LinkDlg.LfC_Select1.Items:=Codeslist;
 LinkDlg.LfC_Select.ItemIndex:=Select_index;
 LinkDlg.LfC_Select1.ItemIndex:=Select_index;
 LinkDlg.LfC_Select.enabled:=false;
 LinkDlg.LfC_Select1.enabled:=false;
 LinkDlg.Link_Select.Items:=Lnk_list;
 LinkDlg.Link_Select.ItemIndex:=0;
 Lnk_list.free;
 LinkDlg.Font:=Font;
 LinkDlg.ShowModal;
 for i:=Links_Panel.ControlCount-1 downto 0 do
  Links_Panel.Controls[i].free;
 links_TabSheetShow(nil);
end;


procedure TSchnipselMainForm.MScrollDownClick(Sender: TObject);
begin
 First_Menu_Item:=Last_Menu_Item;
 Repaint;
end;

procedure TSchnipselMainForm.MScrollUpClick(Sender: TObject);
var MEntrys_on_Panel : integer;
begin
 MEntrys_on_Panel:=round(SideMenu_Panel.height / 30);
 First_Menu_Item:=(Last_Menu_Item-(MEntrys_on_Panel*2)+4);
 if (First_Menu_Item<0) then
  begin
   First_Menu_Item:=0;
   MScrollUp.enabled:=false;
  end;
 Repaint;
end;


procedure TSchnipselMainForm.ShowSplash_ButtonClick(Sender: TObject);
var i : integer;
begin
 for i:=LTPanel.ControlCount-1 downto 0 do
  LTPanel.controls[i].free;
 Code_PageControl.visible:=false;
 LTpanel.visible:=true;
 showsplash;
end;


procedure TSchnipselMainForm.ExportasPDFBtnClick(Sender: TObject);
var ExportPDF  : TPdfDoc;
    PDFLines   : Tstringlist;
    CodeLines  : Tstringlist;
    HeadLine   : string;
    s          : string;
    Lid,Tid,
    reacid,
    i,j,Lcount,
    MaxLength  : integer;
    FoutFile   : TFileStream;
    stra       : array of string;
    schnipsel_ini : TiniFile;
begin
 if(ExportList.count=0) then
  exit;
 try
  schnipsel_ini:=TiniFile.create(sysutils.GetEnvironmentVariable('localappdata')+DirectorySeparator+'Schnipsel'+DirectorySeparator+'Schnipsel.ini');
  ExportPDFDlg.ExpPDFAuthor.text:=schnipsel_ini.ReadString('PDF','Author','');
  ExportPDFDlg.ExpPDFKeywords.text:=schnipsel_ini.ReadString('PDF','Keywords','');
  ExportPDFDlg.ExpPDFTitle.text:=schnipsel_ini.ReadString('PDF','Title','');
  ExportPDFDlg.ExpPDFSubject.text:=schnipsel_ini.ReadString('PDF','Subject','');
 finally
  schnipsel_ini.free;
 end;
 ExportSaveDialog.Filter:='PDF-File|.pdf';
 ExportSaveDialog.FileName:='Export.pdf';
 if(ExportSaveDialog.execute) then
  if(ExportPDFDlg.showModal = mrok) then
   begin
    try
     schnipsel_ini:=TiniFile.create(sysutils.GetEnvironmentVariable('localappdata')+DirectorySeparator+'Schnipsel'+DirectorySeparator+'Schnipsel.ini');
     schnipsel_ini.WriteString('PDF','Author',ExportPDFDlg.ExpPDFAuthor.text);
     schnipsel_ini.WriteString('PDF','Keywords',ExportPDFDlg.ExpPDFKeywords.text);
     schnipsel_ini.WriteString('PDF','Title',ExportPDFDlg.ExpPDFTitle.text);
     schnipsel_ini.WriteString('PDF','Subject',ExportPDFDlg.ExpPDFSubject.text);
    finally
     schnipsel_ini.free;
    end;
    Pbar.Position:=1;
    Pbar.Min:=1;
    Pbar.Max:=ExportList.Count;
    if(ExportList.Count=1) then
     Pbar.Style:=pbstMarquee
    else
     Pbar.Style:=pbstNormal;
    ExportPDF:=TPdfDoc.create;
    ExportPDF.NewDoc;
    ExportPDF.Info.Author:=ExportPDFDlg.ExpPDFAuthor.text;
    ExportPDF.Info.Keywords:=ExportPDFDlg.ExpPDFKeywords.text;
    ExportPDF.Info.Title:=ExportPDFDlg.ExpPDFTitle.text;
    ExportPDF.Info.Subject:=ExportPDFDlg.ExpPDFSubject.text;
    PDFLines:=Tstringlist.create;
    for i:=0 to ExportList.count-1 do
     begin
      Pbar.Position:=Pbar.Position+1;
      Pbar.Update;
      sleep(500);
      stra:=ExportList[i].split('_');
      try
       SQLQuery1.SQL.Text := 'SELECT cn.id as reacid, cn.lang_id as Langid ,cn.type_id as Typeid ,c.schnipsel as Ctext, cn.Schnipsel_Name as Cname from schnipsel_names as cn left join schnipsel_codes as c on c.schnipsel_id=cn.id where c.id=:Code_id';
       SQLQuery1.Params.ParamByName('Code_id').asInteger:=strtoint(stra[0]);
       SQLQuery1.Open;
       reacid:=SQLQuery1.FieldByName('reacid').AsInteger;
       Lid:=SQLQuery1.FieldByName('Langid').AsInteger;
       Tid:=SQLQuery1.FieldByName('Typeid').AsInteger;
       HeadLine:=SQLQuery1.FieldByName('Cname').AsString;
       CodeLines:=Tstringlist.create;
       CodeLines.LoadFromStream(sqlquery1.CreateBlobStream(SQLQuery1.Fields[3],bmread));
       SQLQuery1.Close;
      except
       on E: ESQLDatabaseError do
             messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
      end;
      try
       SQLQuery1.SQL.Text := 'SELECT l.Language as Lname ,l.Lang_short as Lshort ,t.TypeName as Tname from schnipsel_language as l join schnipsel_types as t where t.id=:T_id and l.id=:L_id';
       SQLQuery1.Params.ParamByName('L_id').asString:=inttostr(Lid);
       SQLQuery1.Params.ParamByName('T_id').asString:=inttostr(Tid);
       SQLQuery1.Open;
       PDFLines.add('|LINE|');
       PDFLines.add('|HEADLINE|'+HeadLine);
       PDFLines.add(' ');
       PDFLines.add(Exportstr7+SQLQuery1.FieldByName('Lname').AsString+' ('+SQLQuery1.FieldByName('Lshort').AsString+')');
       PDFLines.add(Exportstr8+SQLQuery1.FieldByName('Tname').AsString);
       PDFLines.add(' ');
       for j:=0 to CodeLines.count-1 do
        PDFLines.add(CodeLines[j]);
       CodeLines.free;
       SQLQuery1.Close;
      except
       on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
      end;
      if(stra[1]='1') then
       begin
        PDFLines.add(' ');
        PDFLines.add(' ');
        PDFLines.add('|BOLD|'+Exportstr9);
        try
         SQLQuery1.SQL.Text := 'SELECT required_name, required_hint,required_link from schnipsel_required where code_id=:Cid';
         SQLQuery1.Params.ParamByName('Cid').asInteger:=reacid;
         SQLQuery1.Open;
         while not SQLQuery1.EOF do
          begin
           PDFLines.add(' ');
           PDFLines.add(Exportstr10+SQLQuery1.FieldByName('required_name').AsString);
           PDFLines.add(Exportstr11+SQLQuery1.FieldByName('required_hint').AsString);
           PDFLines.add(Exportstr12+SQLQuery1.FieldByName('required_link').AsString);
           SQLQuery1.next;
          end;
         SQLQuery1.Close;
        except
         on E: ESQLDatabaseError do
               messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
        end;
       end;
      if(stra[2]='1') then
       begin
        PDFLines.add(' ');
        PDFLines.add(' ');
        PDFLines.add('|BOLD|'+Exportstr13);
        try
         SQLQuery1.SQL.Text := 'SELECT author, comment from schnipsel_comments where code_id=:Cid';
         SQLQuery1.Params.ParamByName('Cid').asInteger:=reacid;
         SQLQuery1.Open;
         while not SQLQuery1.EOF do
          begin
           PDFLines.add(' ');
           PDFLines.add(Exportstr14+SQLQuery1.FieldByName('author').AsString);
           PDFLines.add(Exportstr15+SQLQuery1.FieldByName('comment').AsString);
           SQLQuery1.next;
          end;
         SQLQuery1.Close;
        except
         on E: ESQLDatabaseError do
               messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
        end;
       end;
      if(stra[3]='1') then
       begin
        PDFLines.add(' ');
        PDFLines.add(' ');
        PDFLines.add('|BOLD|'+Exportstr16);
        try
         SQLQuery1.SQL.Text := 'SELECT link_text, link_url from schnipsel_links where code_id=:Cid';
         SQLQuery1.Params.ParamByName('Cid').asInteger:=reacid;
         SQLQuery1.Open;
         while not SQLQuery1.EOF do
          begin
           PDFLines.add(' ');
           PDFLines.add(Exportstr17+SQLQuery1.FieldByName('link_text').AsString);
           PDFLines.add(Exportstr18+SQLQuery1.FieldByName('link_url').AsString);
           PDFLines.add(' ');
           PDFLines.add(' ');
           SQLQuery1.next;
          end;
         SQLQuery1.Close;
        except
         on E: ESQLDatabaseError do
               messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
        end;
       end;
      if((ExportPDFDlg.ExpPDFocop.checked=true) and (i<ExportList.count-1)) then
            PDFLines.add('|NEWPAGE|');
     end;
    ExportPDF.AddPage;
    ExportPDF.Canvas.SetFont('Arial', 9);
    j:=760;
    Lcount:=1;
    for i:=1 to PDFLines.count do
     begin
      if ((i mod 60 = 0) and (ExportPDFDlg.ExpPDFocop.checked=false)) or (Lcount=60) or (pos('|NEWPAGE|',PDFLines[i-1])>0) then
       begin
        s:=FormatDateTime(Exportstr19, Date);
        ExportPDF.Canvas.setFont('Arial',9);
        ExportPDF.Canvas.BeginText;
        ExportPDF.Canvas.MoveTextPoint(580-ExportPDF.Canvas.textwidth(s),790);
        ExportPDF.Canvas.ShowText(s);
        ExportPDF.Canvas.EndText;
        ExportPDF.AddPage;
        J:=760;
        Lcount:=1;
       end;
      if(PDFLines[i-1] <> ' ') then
       begin
        if(pos('|HEADLINE|',PDFLines[i-1])>0) or (pos('|BOLD|',PDFLines[i-1])>0) then
         begin
          PDFLines[i-1]:=PDFLines[i-1].replace('|HEADLINE|','');
          ExportPDF.Canvas.SetFont('Arial-Bold', 10);
          if(pos('|BOLD|',PDFLines[i-1])>0) then
           ExportPDF.Canvas.SetFont('Arial-Bold', 9);
          PDFLines[i-1]:=PDFLines[i-1].replace('|BOLD|','');
         end
        else
         ExportPDF.Canvas.SetFont('Arial', 9);
        if(pos('|LINE|',PDFLines[i-1])>0) then
         begin
          ExportPDF.Canvas.SetLineWidth(0.75);
          ExportPDF.Canvas.MoveTo(40, j);
          ExportPDF.Canvas.LineTo(580,j);
          ExportPDF.Canvas.Stroke;
         end;
        MaxLength:=ExportPDF.Canvas.MeasureText(PDFLines[i-1],550);
        if(length(PDFLines[i-1]) > MaxLength) then
         repeat
          Lid:=0;
          for Tid:=MaxLength downto 1 do
           begin
            if(PDFLines[i-1][Tid]=' ') then
             if(Lid=0) then
              Lid:=Tid;
           end;
          if(Lid>0) then
           begin
            s:=system.copy(PDFLines[i-1],1,Lid);
            PDFLines[i-1]:='  '+system.copy(PDFLines[i-1],lid+1,length(PDFLines[i-1]));
            ExportPDF.Canvas.BeginText;
            ExportPDF.Canvas.MoveTextPoint(40,j);
            ExportPDF.Canvas.ShowText(s);
            ExportPDF.Canvas.EndText;
            inc(Lcount,1);
            dec(j,12);
           end;
         until (Length(PDFLines[i-1]) <=MaxLength);
        if(pos('|LINE|',PDFLines[i-1])=0) and (pos('|NEWPAGE|',PDFLines[i-1])=0) then
         begin
          ExportPDF.Canvas.BeginText;
          ExportPDF.Canvas.MoveTextPoint(40,j);
          ExportPDF.Canvas.ShowText(PDFLines[i-1]);
          ExportPDF.Canvas.EndText;
         end;
       end;
      inc(Lcount,1);
      dec(j,12);
     end;
   s:=FormatDateTime(Exportstr19, Date);
   ExportPDF.Canvas.SetFont('Arial',9);
   ExportPDF.Canvas.BeginText;
   ExportPDF.Canvas.MoveTextPoint(580-ExportPDF.Canvas.textwidth(s),790);
   ExportPDF.Canvas.ShowText(s);
   ExportPDF.Canvas.EndText;
   FOutFile := TFileStream.Create(ExportSaveDialog.FileName, fmCreate);
   ExportPDF.SaveToStream(FoutFile);
   PDFLines.free;
   ExportPDF.free;
   FoutFile.free;
   Pbar.Position:=0;
   openurl(ExportSaveDialog.FileName)
  end;
end;


procedure TSchnipselMainForm.MainMenu_ButtonClick(Sender: TObject);
var p : tpoint;
begin
 p:=ClientToScreen(Point((Sender as TControl).Left,(Sender as TControl).Top));
 PopupMainMenu.PopUp(p.x-30,p.y+35);
end;


procedure TSchnipselMainForm.RcodeEntryClick(Sender : Tobject);
var stra : array of string;
begin
 stra:=(Sender as TImage).name.split('_');
 Selected_Code_ID:=strtoint(stra[1]);
 Selected_Version_ID:=0;
 Application.QueueAsyncCall(@AsyncFree, PtrInt(Sender));
end;


procedure TSchnipselMainForm.AsyncFree(AData: PtrInt);
var j : integer;
begin
 TObject(AData).Free;
 for j:=Requires_Panel.ControlCount-1 downto 0 do
  Requires_Panel.Controls[j].free;
 for j:=Comment_Panel.ControlCount-1 downto 0 do
  Comment_Panel.Controls[j].free;
 for j:=Links_Panel.ControlCount-1 downto 0 do
  Links_Panel.Controls[j].free;
 for j:=Code_Tabsheet.controlcount-1 downto 0 do
  if ((Code_Tabsheet.controls[j] is Tstatictext) and (Code_Tabsheet.controls[j].name <> 'CodeVersion')) then
   Code_Tabsheet.controls[j].free;
 CodeMemo.Clear;
 Code_PageControl.ActivePage:=Code_TabSheet;
 showCodeEntry(Selected_Code_ID);
end;


procedure TSchnipselMainForm.RcodeLinkClick(Sender : Tobject);
begin
 openurl((Sender as TImage).hint);
end;


procedure TSchnipselMainForm.Requires_TabSheetShow(Sender: TObject);
var R_id,
    Pos_Top : integer;
    TI,LTI,
    CTI     : TImage;
    Rname   : TStatictext;
    Rhint   : Tstatictext;
    Centry_line    : TdividerBevel;
begin
 try
  SQLQuery1.SQL.Text := 'select r.id as R_id, r.required_id as requiredID, r.required_name as Rname, r.required_link as Rlink, r.required_hint as Rhint from schnipsel_required as r where code_id=:C_id order by r.id DESC';
  SQLQuery1.Params.ParamByName('C_id').asInteger:= Selected_Code_ID;
  SQLQuery1.Open;
  Pos_Top:=20;
  while not SQLQuery1.EOF do
     begin
      R_id:=SQLQuery1.FieldByName('R_id').AsInteger;
      TI:=Timage.create(nil);
      TI.SetBounds(15,Pos_Top,16,16);
      TI.Parent:=Requires_Panel;
      ImageList_white.GetBitmap(13, TI.Picture.Bitmap);
      Rname:=Tstatictext.create(nil);
      Rname.setbounds(35,Pos_Top,200,16);
      Rname.Caption:=SQLQuery1.FieldByName('Rname').AsString;
      Rname.font.style:=Rname.font.style+[fsBold];
      Rname.Parent:=Requires_Panel;
      if(SQLQuery1.FieldByName('RequiredID').AsInteger > 0) then
       begin
        CTI:=Timage.create(nil);
        CTI.setbounds(430,Pos_Top,16,16);
        ImageList_white.GetBitmap(18, CTI.Picture.Bitmap);
        CTI.Name:='RcodeEntry_'+inttostr(SQLQuery1.FieldByName('RequiredID').AsInteger);
        CTI.OnClick:=@RcodeEntryClick;
        CTI.onMouseEnter:=@LinkImage;
        CTI.Parent:=Requires_Panel;
       end;
      LTI:=Timage.create(nil);
      LTI.setbounds(460,Pos_Top,16,16);
      LTI.showhint:=true;
      LTI.hint:=SQLQuery1.FieldByName('Rlink').AsString;
      if(LTI.hint > '') then
       LTI.onClick:=@RcodeLinkClick
      else
       LTI.hint:=Centrystr3;
      LTI.onMouseEnter:=@LinkImage;
      LTI.Parent:=Requires_Panel;
      ImageList_white.GetBitmap(19, LTI.Picture.Bitmap);
      Rhint:=Tstatictext.create(nil);
      Rhint.setbounds(35,Pos_Top+20,440,34);
      Rhint.Caption:=SQLQuery1.FieldByName('Rhint').AsString;
      Rhint.Parent:=Requires_Panel;
      CEntry_line:=TDividerBevel.create(nil);
      CEntry_line.setbounds(35,Pos_Top+60,450,15);
      CEntry_Line.BevelStyle:=bsLowered;
      CEntry_Line.Parent:=Requires_Panel;
      inc(Pos_Top,85);
      SQLQuery1.Next;
     end;
    SQLQuery1.Close;
   except
    on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
end;


procedure TSchnipselMainForm.Comment_TabSheetShow(Sender: TObject);
var Cm_id,
    Pos_Top : integer;
    TI      : TImage;
    Cauthor : TStatictext;
    Ccomment: Tstatictext;
    Centry_line : TdividerBevel;
begin
 try
  SQLQuery1.SQL.Text := 'select c.id as Cm_id, c.author as Cauthor, c.Comment as Ccomment from schnipsel_comments as c where code_id=:C_id and parent_id=0 order by c.id DESC';
  SQLQuery1.Params.ParamByName('C_id').asInteger:= Selected_Code_ID;
  SQLQuery1.Open;
  Pos_Top:=20;
  while not SQLQuery1.EOF do
     begin
      Cm_id:=SQLQuery1.FieldByName('Cm_id').AsInteger;
      TI:=Timage.create(nil);
      TI.setbounds(15,Pos_Top,16,16);
      ImageList_white.GetBitmap(14, TI.Picture.Bitmap);
      TI.Parent:=Comment_Panel;
      Cauthor:=Tstatictext.create(nil);
      Cauthor.setbounds(35,Pos_Top,400,16);
      Cauthor.Caption:=SQLQuery1.FieldByName('Cauthor').AsString;
      Cauthor.font.style:=Cauthor.font.style+[fsBold];
      Cauthor.Parent:=Comment_Panel;
      Ccomment:=Tstatictext.create(nil);
      Ccomment.setbounds(35,Pos_Top+20,440,44);
      Ccomment.Caption:=SQLQuery1.FieldByName('Ccomment').AsString;
      Ccomment.Parent:=Comment_Panel;
      Centry_line:=TDividerBevel.create(nil);
      Centry_Line.setbounds(35,Pos_Top+70,450,15);
      CEntry_Line.BevelStyle:=bsLowered;
      Centry_Line.Parent:=Comment_Panel;
      inc(Pos_Top,85);
      SQLQuery1.Next;
     end;
    SQLQuery1.Close;
   except
    on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
end;

procedure TSchnipselMainForm.Edit_Mode_ButtonClick(Sender: TObject);
begin
 if (Edit_Mode=true) then
  begin
   Edit_Mode:=false;
   CodeAddVerBtn.visible:=false;
   CodeEditBtn.visible:=false;
   CodeDeleteBtn.Visible:=false;;
   CodeDelVerBtn.visible:=false;
   Edit_Comments_Button.visible:=false;
   Edit_Links_Button.visible:=false;
   Edit_Required_Button.visible:=false;
   Edit_Mode_Button.ImageIndex:=17;
   Editor_Panel.visible:=false;
   width:=Constraints.MinWidth;
   height:=Constraints.Minheight;
   if(Export_Mode=true) then
    width:=width+Export_Panel.width+5;
  end
 else
 begin
  Edit_Mode:=true;
  CodeAddVerBtn.visible:=true;
  CodeEditBtn.visible:=true;
  CodeDeleteBtn.visible:=true;
  CodeDelVerBtn.visible:=true;
  Edit_Comments_Button.visible:=true;
  Edit_Links_Button.visible:=true;
  Edit_Required_Button.visible:=true;
  Edit_Mode_Button.ImageIndex:=23;
  if(WindowState=wsMaximized) then
   Editor_Panel.width:=width-Editor_Panel.left
  else
   width:=width+471;
  Editor_Panel.visible:=true;
  if(width > screen.Desktopwidth) then
   width:=screen.Desktopwidth;
  Editor_Panel.visible:=true;
 end;
end;


procedure TSchnipselMainForm.Links_TabSheetShow(Sender: TObject);
var L_id    : integer;
    Pos_Top : integer;
    TI      : TImage;
    L_name  : TStatictext;
    L_url   : Tstatictext;
    Centry_line : TdividerBevel;
begin
 try
  SQLQuery1.SQL.Text := 'select l.id as l_id, l.link_text as L_name, l.link_url as L_url from schnipsel_links as l where code_id=:C_id order by l.id DESC';
  SQLQuery1.Params.ParamByName('C_id').asInteger:= Selected_Code_ID;
  SQLQuery1.Open;
  Pos_Top:=20;
  while not SQLQuery1.EOF do
     begin
      L_id:=SQLQuery1.FieldByName('L_id').AsInteger;
      TI:=Timage.create(nil);
      TI.setbounds(15,Pos_Top,16,16);
      ImageList_white.GetBitmap(15, TI.Picture.Bitmap);
      TI.Parent:=Links_Panel;
      L_name:=Tstatictext.create(nil);
      L_name.setbounds(35,Pos_Top,440,16);
      L_name.Font.style:=L_name.Font.style+[fsBold];
      L_name.Caption:=SQLQuery1.FieldByName('L_name').AsString;
      L_name.Parent:=Links_Panel;
      L_url:=Tstatictext.create(nil);
      L_url.setbounds(35,Pos_Top+20,440,16);
      L_url.onMouseEnter:=@TextFontLink;
      L_url.onMouseLeave:=@TextFontNormal;;
      L_url.onClick:=@LinkTabClick;
      L_url.Caption:=SQLQuery1.FieldByName('L_url').AsString;
      L_url.Parent:=Links_Panel;
      Centry_line:=TDividerBevel.create(nil);
      Centry_Line.SetBounds(35,Pos_Top+60,450,15);
      CEntry_Line.BevelStyle:=bsLowered;
      Centry_Line.Parent:=Links_Panel;
      inc(Pos_Top,85);
      SQLQuery1.Next;
     end;
    SQLQuery1.Close;
   except
    on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
end;


procedure TSchnipselMainForm.LinkTabClick(Sender: TObject);
begin
 openDocument((Sender as TStatictext).caption);
end;


procedure TSchnipselMainForm.MenuTextLink(Sender : TObject);
begin
 (sender as Tstatictext).Cursor:=crHandPoint;
end;


procedure TSchnipselMainForm.MenuTextNormal(Sender : TObject);
begin
 (sender as Tstatictext).Cursor:=CrArrow;
end;


procedure TSchnipselMainForm.TextFontLink(Sender : TObject);
begin
 (sender as Tstatictext).Font.Style:=(sender as Tstatictext).Font.Style + [fsUnderline];
 (sender as Tstatictext).Cursor:=crHandPoint;
end;


procedure TSchnipselMainForm.TextFontNormal(Sender : TObject);
begin
 (sender as Tstatictext).Font.Style:=(sender as Tstatictext).Font.Style - [fsUnderline];
 (sender as Tstatictext).Cursor:=CrArrow;
end;


procedure TSchnipselMainForm.NewCodeEntry;
var L_id,T_id,i           : integer;
    Lshort                : string;
    Categories_Short_Full : TstringList;
    Categories_Typenames  : TstringList;
    sa                    : array of string;
begin
 if((Edit_Code_ID > 0) or (CodeEditor.enabled=true)) then
  if(messageDlgPos(Editorstr7+slinebreak+Editorstr9,mtConfirmation,[mbYes,mbNo],0,
                   round(left+(width/2)),round(top+(height/2))) = mrNo) then
   exit
  else
   Edit_Code_ID:=0;
 Categories_Short_Full:=TstringList.create;
 Categories_Typenames:=TstringList.create;
 try
  SQLQuery1.SQL.Text := 'select l.id as Lid, l.language as Llang, l.lang_short as Lshort from schnipsel_language as l';
  SQLQuery1.Open;
  while not SQLQuery1.EOF do
   begin
    L_id:=SQLQuery1.FieldByName('Lid').AsInteger;
    Lshort:=SQLQuery1.FieldByName('Lshort').AsString;
    Categories_Short_Full.add(inttostr(L_id)+'_'+Lshort+' -> '+SQLQuery1.FieldByName('Llang').AsString);
    SQLQuery1.Next;
   end;
  SQLQuery1.Close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 try
  SQLQuery1.SQL.Text := 'select t.id as tid, t.typename as Typename from schnipsel_types as t';
  SQLQuery1.Open;
  while not SQLQuery1.EOF do
   begin
    T_id:=SQLQuery1.FieldByName('tid').AsInteger;
    Categories_Typenames.add(inttostr(T_id)+'_'+SQLQuery1.FieldByName('Typename').AsString);
    SQLQuery1.Next;
   end;
  SQLQuery1.Close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 NewCodeEntryDlg.NCLang_Select.Items:=Categories_Short_Full;
 NewCodeEntryDlg.NCType_Select.Items:=Categories_Typenames;
 NewCodeEntryDlg.NCType_Select.ItemIndex:=0;
 NewCodeEntryDlg.NCLang_Select.ItemIndex:=0;
 NewCodeEntryDlg.Font:=Font;
 if (NewCodeEntryDlg.ShowModal = mrOk) then
  begin
   if (Edit_Mode=false) then
    begin
     Edit_Mode:=true;
     CodeAddVerBtn.visible:=true;
     CodeEditBtn.visible:=true;
     CodeDeleteBtn.visible:=true;
     CodeDelVerBtn.visible:=true;
     Edit_Comments_Button.visible:=true;
     Edit_Links_Button.visible:=true;
     Edit_Required_Button.visible:=true;
     Edit_Mode_Button.ImageIndex:=23;
     Editor_Panel.visible:=true;
     width:=width+471;
     if(width > screen.Desktopwidth) then
      width:=screen.Desktopwidth;
    end;
   sa:=NewCodeEntryDlg.NCLang_Select.Items[NewCodeEntryDlg.NCLang_Select.ItemIndex].Split('_');
   L_id:=strtoint(sa[0]);
   sa:=NewCodeEntryDlg.NCType_Select.Items[NewCodeEntryDlg.NCType_Select.ItemIndex].Split('_');
   T_id:=strtoint(sa[0]);
   try
    SQLQuery1.SQL.Text := 'insert into schnipsel_names (lang_id,type_id,Schnipsel_Name) values(:L_id,:T_id,:Cname)';
    SQLQuery1.Params.ParamByName('L_id').asInteger:=L_id;
    SQLQuery1.Params.ParamByName('T_id').asInteger:=T_id;
    SQLQuery1.Params.ParamByName('Cname').asString:=trim(NewCodeEntryDlg.NewCodeName.text).replace('_','-',[rfReplaceAll]);
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
          messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   i:=0;
   try
    if(DBEngine='SQLite') then
     SQLQuery1.SQL.Text := 'SELECT last_insert_rowid() as Last_id from schnipsel_names'
    else
     SQLQuery1.SQL.Text := 'SELECT LAST_INSERT_ID(Id) as Last_id from schnipsel_names order by LAST_INSERT_ID(Id) desc limit 1';
    SQLQuery1.Open;
    i:=SQLQuery1.FieldByName('Last_id').AsInteger;
    SQLQuery1.Close;
   except
    on E: ESQLDatabaseError do
          messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   Edit_Code_ID:=i;
   if(i>0) then
    Selected_Version_Id:=i;
   Editor_Code_Name.enabled:=true;
   Editor_Code_Name.text:=trim(NewCodeEntryDlg.NewCodeName.text).replace('_','-',[rfReplaceAll]);
   Editor_Toolbar.enabled:=true;
   CodeEditor.enabled:=true;
   CodeEditor.Clearall;
   CodeEditor.CaretX :=1;
   CodeEditor.CaretY :=1;
   EditorTB_Author.enabled:=true;
   EditorTB_Version.enabled:=true;
   EditorTB_Author.text:=Editorstr3;
   EditorTB_Version.text:=Editorstr4;
   EditorTB_Version.SetFocus;
  end;
 Categories_Short_Full.free;
 Categories_Typenames.free;
end;


procedure TSchnipselMainForm.MenuEditCategoriesClick(Sender: TObject);
var L_id                  : integer;
    Lshort                : string;
    Categories_Short_full : TStringList;

begin
 Categories_Short_Full:=TStringList.create;
 try
  SQLQuery1.SQL.Text := 'select l.id as Lid, l.language as Llang, l.lang_short as Lshort from schnipsel_language as l';
  SQLQuery1.Open;
  while not SQLQuery1.EOF do
   begin
    L_id:=SQLQuery1.FieldByName('Lid').AsInteger;
    Lshort:=SQLQuery1.FieldByName('Lshort').AsString;
    Categories_Short_Full.add(inttostr(L_id)+'_'+Lshort+' -> '+SQLQuery1.FieldByName('Llang').AsString);
    SQLQuery1.Next;
   end;
  SQLQuery1.Close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 if(Categories_Short_Full.count > 0) then
  begin
   NewCategorieDlg.CategorieListEdit.Items:=Categories_Short_Full;
   NewCategorieDlg.CategorieListEdit.ItemIndex:=0;
   NewCategorieDlg.CategorieListDelete.Items:=Categories_Short_Full;
   NewCategorieDlg.CategorieListDelete.ItemIndex:=0;
   NewCategorieDlg.MoveToListBox.Items:=Categories_Short_Full;
   NewCategorieDlg.MoveToListBox.ItemIndex:=0;
  end;
 NewCategorieDlg.Font:=Font;
 NewCategorieDlg.ShowModal;
 Categories_Short_Full.free;
 Menu_Entrys.clear;
 try
  SQLQuery1.SQL.Text := 'select id,Lang_short from schnipsel_language';
  SQLQuery1.Open;
  while not SQLQuery1.EOF do
   begin
    Menu_Entrys.add(SQLQuery1.FieldByName('Lang_short').AsString+'_'+SQLQuery1.FieldByName('id').AsString);
    SQLQuery1.Next;
   end;
  SQLQuery1.close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 First_Menu_Item:=0;
 RePaint;
end;


procedure TSchnipselMainForm.HelpButtonClick(Sender: TObject);
begin
 openurl('Schnipsel.chm')
end;


procedure TSchnipselMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if(key=112) then
  openurl('Schnipsel.chm')
end;

procedure TSchnipselMainForm.EnglishClick(Sender: TObject);
var schnipsel_ini : TiniFile;
begin
 SetDefaultLang('en');
 GetLocaleFormatSettings($409, DefaultFormatSettings);
 try
  schnipsel_ini:=TiniFile.create(sysutils.GetEnvironmentVariable('localappdata')+DirectorySeparator+'Schnipsel'+DirectorySeparator+'Schnipsel.ini');
  schnipsel_ini.WriteString('Language','Lang','en');
  schnipsel_ini.WriteInteger('Language','Code',$409);
 finally
  schnipsel_ini.free;
 end;
end;


{ DB-Button in Mainmeu is clicked...
  Calling the DB-Configuration-Dialog
  On first run or changing DB-Connection will
  Update Entrys in Menu and  calling SplashScreen }

procedure TSchnipselMainForm.DB_ButtonClick(Sender: TObject);
var DBE : string;
begin
 DBE:=DBEngine;
 DBConfigDlg.Font:=Font;
 if ((DBConfigDlg.showModal = mrOK) and ((Menu_Entrys.count=0) or (DBE<>DBEngine))) then
  begin
   Menu_Entrys.clear;
   try
    SQLQuery1.SQL.Text := 'select id,Lang_short from schnipsel_language';
    SQLQuery1.Open;
    while not SQLQuery1.EOF do
     begin
      Menu_Entrys.add(SQLQuery1.FieldByName('Lang_short').AsString+'_'+SQLQuery1.FieldByName('id').AsString);
      SQLQuery1.Next;
     end;
    SQLQuery1.close;
   except
    on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   if (Menu_Entrys.count>0) then
    begin
     RePaint;
    end;
   showsplash;
  end;
end;


procedure TSchnipselMainForm.DBSearch_ButtonClick(Sender: TObject);
var searchstr : string;
begin
 DBsearchDlg.SearchEdit.text:='';
 if (DBsearchDlg.ShowModal = mrOK) then
  if (trim(DBsearchDlg.SearchEdit.text) > '') then
   DBSearch_results(DBsearchDlg.SearchEdit.text);
end;


procedure TSchnipselMainForm.DBSearch_results(searchstr : string);
var i,TTop,
    C_id        : integer;
    Cname       : string;
    Entry_Image : Timage;
    Tstext      : Tstatictext;
begin
 for i:=LTPanel.ControlCount-1 downto 0 do
  LTPanel.controls[i].free;
 Tstext:=Tstatictext.create(nil);
 Tstext.setbounds(10,15,300,16);
 Tstext.Font.style:=Tstext.Font.style+[fsBold];
 Tstext.Parent:=LTPanel;
 Tstext.caption:=SearchNames;
 TTop:=35;
 WorkSpace_StatusBar.Panels[0].Text:='';
 WorkSpace_StatusBar.Panels[1].Text:='';
 try
  SQLQuery1.SQL.Text := 'select id,Schnipsel_Name from schnipsel_names where Schnipsel_Name like :SearchStr';
  SQLQuery1.Params.ParamByName('SearchStr').asString:='%'+SearchStr+'%';
  SQLQuery1.Open;
  while not SQLQuery1.EOF do
   begin
    C_id:=SQLQuery1.FieldByName('id').AsInteger;
    CName:=SQLQuery1.FieldByName('Schnipsel_Name').AsString;
    Entry_Image:=TImage.create(nil);
    Entry_Image.setbounds(15,TTop,16,16);
    ImageList_white.GetBitmap(13, Entry_Image.Picture.Bitmap);
    Entry_Image.Parent:=LTPanel;
    Tstext:=Tstatictext.create(nil);
    Tstext.setbounds(35,TTop,300,16);
    Tstext.caption:=CName;
    Tstext.name:='Centry_'+inttostr(C_id);
    Tstext.onMouseEnter:=@TextFontLink;
    Tstext.onMouseLeave:=@TextFontNormal;
    Tstext.OnClick:=@CodeEntryClick;
    Tstext.Parent:=LTPanel;
    inc(TTop,20);
    SQLQuery1.Next;
   end;
  SQLQuery1.close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 inc(TTop,20);
 Tstext:=Tstatictext.create(nil);
 Tstext.setbounds(10,TTop,300,16);
 Tstext.Font.style:=Tstext.Font.style+[fsBold];
 Tstext.Parent:=LTPanel;
 Tstext.caption:=SearchCodes;
 inc(TTop,20);
 try
  SQLQuery1.SQL.Text := 'select sc.id as Cid, sn.schnipsel_name as Cname from schnipsel_names as sn left join schnipsel_codes as sc on sn.id=sc.schnipsel_id where Schnipsel like :SearchStr';
  SQLQuery1.Params.ParamByName('SearchStr').asString:='%'+SearchStr+'%';
  SQLQuery1.Open;
  while not SQLQuery1.EOF do
   begin
    C_id:=SQLQuery1.FieldByName('Cid').AsInteger;
    CName:=SQLQuery1.FieldByName('CName').AsString;
    Entry_Image:=TImage.create(nil);
    Entry_Image.setbounds(15,TTop,16,16);
    ImageList_white.GetBitmap(13, Entry_Image.Picture.Bitmap);
    Entry_Image.Parent:=LTPanel;
    Tstext:=Tstatictext.create(nil);
    Tstext.setbounds(35,TTop,300,16);
    Tstext.caption:=CName;
    Tstext.name:='Centry_'+inttostr(C_id);
    Tstext.onMouseEnter:=@TextFontLink;
    Tstext.onMouseLeave:=@TextFontNormal;
    Tstext.OnClick:=@CodeEntryClick;
    Tstext.Parent:=LTPanel;
    inc(TTop,20);
    SQLQuery1.Next;
   end;
  SQLQuery1.close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 LangTypesList.visible:=true;
 Code_PageControl.visible:=false;
 LTpanel.visible:=true;
end;


procedure TSchnipselMainForm.GermanClick(Sender: TObject);
var schnipsel_ini : TiniFile;
begin
 SetDefaultLang('de');
 GetLocaleFormatSettings($407, DefaultFormatSettings);
 try
  schnipsel_ini:=TiniFile.create(sysutils.GetEnvironmentVariable('localappdata')+DirectorySeparator+'Schnipsel'+DirectorySeparator+'Schnipsel.ini');
  schnipsel_ini.WriteString('Language','Lang','de');
  schnipsel_ini.WriteInteger('Language','Code',$407);
 finally
  schnipsel_ini.free;
 end;
end;

procedure TSchnipselMainForm.MemoCopyClick(Sender: TObject);
begin
 CodeMemo.CopyToClipboard;
end;

procedure TSchnipselMainForm.MemoSelectAllClick(Sender: TObject);
begin
 if (CodeMemo.Sellength > 0) then
  CodeMemo.Sellength:=0
 else
  CodeMemo.SelectAll;
end;


procedure TSchnipselMainForm.FormWindowStateChange(Sender: TObject);
begin
 if ((WindowState = wsMinimized) and (TopForm.visible=true)) then TopForm.Show;
end;


procedure TSchnipselMainForm.Favorites_ButtonClick(Sender: TObject);
var i,TTop,
    C_id        : integer;
    Cname       : string;
    Entry_Image : TImage;
    Tstext      : Tstatictext;
begin
 for i:=LTPanel.ControlCount-1 downto 0 do
  LTPanel.controls[i].free;
 Tstext:=Tstatictext.create(nil);
 Tstext.setbounds(10,15,300,16);
 Tstext.Font.style:=Tstext.Font.style+[fsBold];
 Tstext.Parent:=LTPanel;
 Tstext.caption:=Favorites;
 TTop:=40;
 try
  SQLQuery1.SQL.Text := 'select f.id as Fid,c.id as Cid, c.Schnipsel_Name as CName from schnipsel_favorites as f left join schnipsel_names as c on f.schnipsel_id=c.id order by f.id DESC';
  SQLQuery1.Open;
  WorkSpace_StatusBar.Panels[0].Text:='';
  if (SQLQuery1.RowsAffected > 0) then
   WorkSpace_StatusBar.Panels[1].Text:=Favorites+' '+PanelEntrys+' '+inttostr(SQLQuery1.RowsAffected)
  else
   WorkSpace_StatusBar.Panels[1].Text:=Favorites+' '+Panel0Entrys;
  while not SQLQuery1.EOF do
   begin
    C_id:=SQLQuery1.FieldByName('Cid').AsInteger;
    CName:=SQLQuery1.FieldByName('CName').AsString;
    Entry_Image:=TImage.create(nil);
    Entry_Image.setbounds(15,TTop,16,16);
    ImageList_white.GetBitmap(13, Entry_Image.Picture.Bitmap);
    Entry_Image.Parent:=LTPanel;
    Tstext:=Tstatictext.create(nil);
    Tstext.Font:=Font;
    Tstext.setbounds(35,TTop,300,16);
    Tstext.caption:=CName;
    Tstext.name:='Centry_'+inttostr(C_id);
    Tstext.onMouseEnter:=@TextFontLink;
    Tstext.onMouseLeave:=@TextFontNormal;
    Tstext.OnClick:=@CodeEntryClick;
    Tstext.Parent:=LTPanel;
    inc(TTop,20);
    SQLQuery1.Next;
   end;
  SQLQuery1.close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 LangTypesList.visible:=true;
 Code_PageControl.visible:=false;
 LTpanel.visible:=true;
end;


procedure TSchnipselMainForm.Bookmark_ButtonClick(Sender: TObject);
var i,TTop      : integer;
    C_id        : integer;
    Cname       : string;
    Entry_Image : TImage;
    Tstext      : Tstatictext;
begin
 for i:=LTPanel.ControlCount-1 downto 0 do
  LTPanel.controls[i].free;
 Tstext:=Tstatictext.create(nil);
 Tstext.setbounds(10,15,300,16);
 Tstext.Font.style:=Tstext.Font.style+[fsBold];
 Tstext.Parent:=LTPanel;
 Tstext.caption:=Bookmarks;
 TTop:=40;
 try
  SQLQuery1.SQL.Text := 'select f.id as fid,c.id as Cid, c.Schnipsel_Name as CName from schnipsel_bookmarks as f left join schnipsel_names as c on f.schnipsel_id=c.id order by f.id DESC limit 6';
  SQLQuery1.Open;
  WorkSpace_StatusBar.Panels[0].Text:='';
  if (SQLQuery1.RowsAffected > 0) then
   WorkSpace_StatusBar.Panels[1].Text:=Bookmarks+' '+PanelEntrys+' '+inttostr(SQLQuery1.RowsAffected)
  else
   WorkSpace_StatusBar.Panels[1].Text:=Bookmarks+' '+Panel0Entrys;
  while not SQLQuery1.EOF do
   begin
    C_id:=SQLQuery1.FieldByName('Cid').AsInteger;
    CName:=SQLQuery1.FieldByName('CName').AsString;
    Entry_Image:=TImage.create(nil);
    Entry_Image.setbounds(15,TTop,16,16);
    ImageList_white.GetBitmap(13, Entry_Image.Picture.Bitmap);
    Entry_Image.Parent:=LTPanel;
    Tstext:=Tstatictext.create(nil);
    Tstext.Font:=Font;
    Tstext.setbounds(35,TTop,300,16);
    Tstext.caption:=CName;
    Tstext.name:='Centry_'+inttostr(C_id);
    Tstext.onMouseEnter:=@TextFontLink;
    Tstext.onMouseLeave:=@TextFontNormal;
    Tstext.OnClick:=@CodeEntryClick;
    Tstext.Parent:=LTPanel;
    inc(TTop,20);
    SQLQuery1.Next;
   end;
  SQLQuery1.close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 LangTypesList.visible:=true;
 Code_PageControl.visible:=false;
 LTpanel.visible:=true;
end;


function SColorToHtmlColor(Color: TColor): string;
var
  N: Longint;
begin
  if Color=clNone then
    begin Result:= ''; exit end;
  N:= ColorToRGB(Color);
  Result:= '#'+
    IntToHex(Red(N), 2)+
    IntToHex(Green(N), 2)+
    IntToHex(Blue(N), 2);
end;


procedure TSchnipselMainForm.ExportasHTMLBtnClick(Sender: TObject);
var HTMLFile   : Tstringlist;
    HTMLLines  : TstringList;
    CodeLines : TstringList;
    reacid,i,
    Lid,Tid,
    ExpCount  : Integer;
    s         : string;
    stra      : array of string;
    c1,c2,
    c3,c4,c5  : string;
begin
 case RBcolor of
  'blue'  : begin
             c1:=SColorToHtmlColor(SettingsDialog.Shape1.Pen.Color);
             c2:=SColorToHtmlColor(SettingsDialog.Shape2.Pen.Color);
             c3:=SColorToHtmlColor(SettingsDialog.Shape3.Pen.Color);
             c4:=SColorToHtmlColor(SettingsDialog.Shape4.Pen.Color);
             c5:=SColorToHtmlColor(SettingsDialog.Shape5.Pen.Color);
            end;
  'green' : begin
             c1:=SColorToHtmlColor(SettingsDialog.Shape6.Pen.Color);
             c2:=SColorToHtmlColor(SettingsDialog.Shape7.Pen.Color);
             c3:=SColorToHtmlColor(SettingsDialog.Shape8.Pen.Color);
             c4:=SColorToHtmlColor(SettingsDialog.Shape9.Pen.Color);
             c5:=SColorToHtmlColor(SettingsDialog.Shape10.Pen.Color);
            end;
  'red'   : begin
             c1:=SColorToHtmlColor(SettingsDialog.Shape11.Pen.Color);
             c2:=SColorToHtmlColor(SettingsDialog.Shape12.Pen.Color);
             c3:=SColorToHtmlColor(SettingsDialog.Shape13.Pen.Color);
             c4:=SColorToHtmlColor(SettingsDialog.Shape14.Pen.Color);
             c5:=SColorToHtmlColor(SettingsDialog.Shape15.Pen.Color);
            end;
  'brown' : begin
             c1:=SColorToHtmlColor(SettingsDialog.Shape16.Pen.Color);
             c2:=SColorToHtmlColor(SettingsDialog.Shape17.Pen.Color);
             c3:=SColorToHtmlColor(SettingsDialog.Shape18.Pen.Color);
             c4:=SColorToHtmlColor(SettingsDialog.Shape19.Pen.Color);
             c5:=SColorToHtmlColor(SettingsDialog.Shape20.Pen.Color);
            end;
 end;
 if(ExportList.count=0) then
  exit;
 ExportSaveDialog.Filter:='HTML-File|.html';
 ExportSaveDialog.FileName:='Export.html';
 if(ExportSaveDialog.execute) then
  begin
   CodeLines:=Tstringlist.create;
   CodeLines.loadfromfile(ExpCSS); //'Templates'+DirectorySeparator+'Template.css');
   Pbar.Position:=1;
   Pbar.Min:=1;
   Pbar.Max:=ExportList.Count;
   if(ExportList.Count=1) then
    Pbar.Style:=pbstMarquee
   else
    Pbar.Style:=pbstNormal;
   HTMLFile:=Tstringlist.create;
   HTMLLines:=Tstringlist.create;
   s:=copy(ExportSaveDialog.FileName,0,length(ExportSaveDialog.FileName)-3);
   HTMLLines.add('<!DOCTYPE html>');
   HTMLLines.add('<html lang="'+setDefaultLang('')+'">');
   HTMLLines.add('<head>');
   HTMLLines.add('<Title>'+ExportSaveDialog.FileName+'</Title>');
   HTMLLines.add('<style>');
   for i:=0 to CodeLines.Count-1 do
    HTMLLines.add(stringsreplace(CodeLines[i],['[TXTCOLOR]','[COLOR1]','[COLOR2]','[COLOR3]','[COLOR4]','[COLOR5]'],[SColorToHtmlColor(stringtocolor(ExpTc)),c1,c2,c3,c4,c5],[rfReplaceAll]));
   HTMLLines.add('</style>');
   HTMLLines.add('</head>');
   HTMLLines.add('<Body>');
   CodeLines.free;
   if(ExpUseHeader=true) then
    begin
     CodeLines:=Tstringlist.create;
     CodeLines.loadfromfile('Templates'+DirectorySeparator+'Header.html');
     for i:=0 to CodeLines.Count-1 do
      HTMLLines.add(CodeLines[i]);
     CodeLines.free;
    end;
   if(pos('list',lowercase(ExpCSS)) > 0) then
    begin
     HTMLLines.add('<div class="sidenav"><ul class="sidenavi">');
     for ExpCount:=0 to ExportList.Count-1 do
      begin
       stra:=ExportList[ExpCount].split('_');
       try
        SQLQuery1.SQL.Text := 'SELECT cn.Schnipsel_Name as Cname from schnipsel_names as cn left join schnipsel_codes as c on c.schnipsel_id=cn.id where c.id=:Code_id';
        SQLQuery1.Params.ParamByName('Code_id').asInteger:=strtoint(stra[0]);
        SQLQuery1.Open;
        HTMLLines.add('<li class="sidenavi"><a href="#c'+inttostr(ExpCount)+'">'+SQLQuery1.FieldByName('Cname').AsString+'</a></li>');
        SQLQuery1.Close;
       except
        on E: ESQLDatabaseError do
              messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
       end;
      end;
     HTMLLines.add('</ul></div>');
    end;
   HTMLLines.add('<div class="main">');
   for i:=0 to HTMLLines.count-1 do
    HTMLFile.add(HTMLLines[i]);
   HTMLLines.clear;
   for ExpCount:=0 to ExportList.Count-1 do
    begin
     Pbar.Position:=Pbar.Position+1;
     Pbar.Update;
     sleep(500);
     stra:=ExportList[ExpCount].split('_');
     HTMLLines.clear;
     try
      SQLQuery1.SQL.Text := 'SELECT cn.id as reacid, cn.lang_id as Langid ,cn.type_id as Typeid ,c.schnipsel as Ctext, cn.Schnipsel_Name as Cname from schnipsel_names as cn left join schnipsel_codes as c on c.schnipsel_id=cn.id where c.id=:Code_id';
      SQLQuery1.Params.ParamByName('Code_id').asInteger:=strtoint(stra[0]);
      SQLQuery1.Open;
      reacid:=SQLQuery1.FieldByName('reacid').AsInteger;
      Lid:=SQLQuery1.FieldByName('Langid').AsInteger;
      Tid:=SQLQuery1.FieldByName('Typeid').AsInteger;
      if(pos('list',lowercase(ExpCSS)) > 0) then
       HTMLLines.add('<Fieldset id="c'+inttostr(ExpCount)+'" class="CodeEntry">')
      else
       HTMLLines.add('<Fieldset id="c'+inttostr(ExpCount)+'" class="CodeEntry">');
      HTMLLines.add('<Legend class="CodeEntry">'+SQLQuery1.FieldByName('Cname').AsString+'</Legend>');
      CodeLines:=Tstringlist.create;
      CodeLines.LoadFromStream(sqlquery1.CreateBlobStream(SQLQuery1.Fields[3],bmread));
      SQLQuery1.Close;
     except
      on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
     end;
     try
      SQLQuery1.SQL.Text := 'SELECT l.Language as Lname ,l.Lang_short as Lshort ,t.TypeName as Tname from schnipsel_language as l join schnipsel_types as t where t.id=:T_id and l.id=:L_id';
      SQLQuery1.Params.ParamByName('L_id').asString:=inttostr(Lid);
      SQLQuery1.Params.ParamByName('T_id').asString:=inttostr(Tid);
      SQLQuery1.Open;
      HTMLLines.add('<p class="Language">'+Exportstr7+SQLQuery1.FieldByName('Lname').AsString+' ('+SQLQuery1.FieldByName('Lshort').AsString+')</p>');
      HTMLLines.add('<p class="Type">'+Exportstr8+SQLQuery1.FieldByName('Tname').AsString+'</p>');
      HTMLLines.add('<div class="CodeLines"><pre><code>');
      for i:=0 to CodeLines.count-1 do
       HTMLLines.add(stringsreplace(CodeLines[i],['<','>'],['&lt;','&gt;'],[rfReplaceAll]));
       HTMLLines.add(CodeLines[i]);
      HTMLLines.add('</code></pre></div>');
      SQLQuery1.Close;
     except
      on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
     end;
     CodeLines.free;
     if(stra[1]='1') then
      begin
       try
        SQLQuery1.SQL.Text := 'SELECT required_name, required_hint,required_link from schnipsel_required where code_id=:Cid';
        SQLQuery1.Params.ParamByName('Cid').asInteger:=reacid;
        SQLQuery1.Open;
        HTMLLines.add('<p class="CodeAppend">'+Exportstr20+'</p>');
        while not SQLQuery1.EOF do
         begin
          HTMLLines.add('<fieldset class="Required">');
          HTMLLines.add('<legend class="Required">'+SQLQuery1.FieldByName('required_name').AsString+'</legend>');
          HTMLLines.add('<p class="Required">'+stringsreplace(SQLQuery1.FieldByName('required_hint').AsString,['<','>'],['&lt;','&gt'],[rfReplaceAll])+'</p>');
          HTMLLines.add('<p class="Required"><a href="'+SQLQuery1.FieldByName('required_link').AsString+'" class="Required">'+SQLQuery1.FieldByName('required_link').AsString+'</a></p>');
          HTMLLines.add('</fieldset>');
          SQLQuery1.next;
         end;
        SQLQuery1.Close;
       except
        on E: ESQLDatabaseError do
             messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
       end;
      end;
     if(stra[2]='1') then
      begin
       try
        SQLQuery1.SQL.Text := 'SELECT author, comment from schnipsel_comments where code_id=:Cid';
        SQLQuery1.Params.ParamByName('Cid').asInteger:=reacid;
        SQLQuery1.Open;
        HTMLLines.add('<p class="CodeAppend">'+Exportstr21+'</p>');
        while not SQLQuery1.EOF do
         begin
          HTMLLines.add('<Fieldset class="Comment">');
          HTMLLines.add('<legend class="Comment">'+SQLQuery1.FieldByName('author').AsString+'</legend>');
          HTMLLines.add('<p class="Comment">'+stringsreplace(SQLQuery1.FieldByName('comment').AsString,['<','>'],['&lt;','&gt'],[rfReplaceAll])+'</p>');
          HTMLLines.add('</fieldset>');
          SQLQuery1.next;
         end;
        SQLQuery1.Close;
       except
        on E: ESQLDatabaseError do
             messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
       end;
      end;
     if(stra[3]='1') then
      begin
       try
        SQLQuery1.SQL.Text := 'SELECT link_text, link_url from schnipsel_links where code_id=:Cid';
        SQLQuery1.Params.ParamByName('Cid').asInteger:=reacid;
        SQLQuery1.Open;
        HTMLLines.add('<p class="CodeAppend">'+Exportstr22+'</p>');
        while not SQLQuery1.EOF do
         begin
          HTMLLines.add('<fieldset class="CodeLinks">');
          HTMLLines.add('<legend class="CodeLinks">'+SQLQuery1.FieldByName('link_text').AsString+'</legend>');
          HTMLLines.add('<p class="CodeLinks"><a href="'+SQLQuery1.FieldByName('link_url').AsString+'" class="CodeLinks">'+SQLQuery1.FieldByName('link_url').AsString+'</a></p>');
          HTMLLines.add('</fieldset>');
          SQLQuery1.next;
         end;
        SQLQuery1.Close;
       except
        on E: ESQLDatabaseError do
             messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
       end;
      end;
     HTMLLines.add('</Fieldset>');
     for i:=0 to HTMLLines.count-1 do
      HTMLFile.add(HTMLLines[i]);
    end;
   HTMLFile.add('</div>');
   if(ExpUseFooter=true) then
    begin
     CodeLines:=Tstringlist.create;
     CodeLines.loadfromfile('Templates'+DirectorySeparator+'Footer.html');
     for i:=0 to CodeLines.Count-1 do
      HTMLFile.add(CodeLines[i]);
     CodeLines.free;
    end;
   HTMLFile.add('</Body>');
   HTMLFile.add('</html>');
   HTMLFile.SaveToFile(ExportSaveDialog.filename);
   HTMLFile.free;
   HTMLLines.free;
   Pbar.Position:=0;
   openurl(ExportSaveDialog.filename);
  end;
end;


procedure TSchnipselMainForm.ExportasXMLBtnClick(Sender: TObject);
var XMLFile   : Tstringlist;
    XMLLines  : TstringList;
    CodeLines : TstringList;
    reacid,i,
    Lid,Tid,
    ExpCount  : Integer;
    stra      : array of string;

begin
 if(ExportList.count=0) then
  exit;
 ExportSaveDialog.Filter:='XML-File|.xml';
 ExportSaveDialog.FileName:='Export.xml';
 if(ExportSaveDialog.execute) then
  begin
   Pbar.Position:=1;
   Pbar.Min:=1;
   Pbar.Max:=ExportList.Count;
   if(ExportList.Count=1) then
    Pbar.Style:=pbstMarquee
   else
    Pbar.Style:=pbstNormal;
   XMLFile:=Tstringlist.create;
   XMLLines:=Tstringlist.create;
   XMLLines.add('<?xml version="1.0" encoding="UTF-8"?>');
   XMLLines.add('<!DOCTYPE SchnipselCode [');
   XMLLines.add('<!ELEMENT SchnipselCode (CodeEntry)+>');
   XMLLines.add('<!ELEMENT CodeEntry (CodeName, CodeLanguage, CodeType, CodeTXT, CodeAppend)+>');
   XMLLines.add('<!ELEMENT CodeName (#PCDATA)>');
   XMLLines.add('<!ELEMENT CodeLanguage (#PCDATA)>');
   XMLLines.add('<!ELEMENT CodeType (#PCDATA)>');
   XMLLines.add('<!ELEMENT CodeTXT (#PCDATA)>');
   XMLLines.add('<!ELEMENT CodeAppend (AppendType)+>');
   XMLLines.add('<!ELEMENT AppendType (CodeRequired, CodeComment, CodeLinks)+>');
   XMLLines.add('<!ELEMENT CodeRequired (RequiredName, RequiredHint, RequiredLink)+>');
   XMLLines.add('<!ELEMENT RequiredName (#PCDATA)>');
   XMLLines.add('<!ELEMENT RequiredHint (#PCDATA)>');
   XMLLines.add('<!ELEMENT RequiredLink (#PCDATA)>');
   XMLLines.add('<!ELEMENT CodeComment (CommentAuthor, CommentComment)+>');
   XMLLines.add('<!ELEMENT CommentAuthor (#PCDATA)>');
   XMLLines.add('<!ELEMENT CommentComment (#PCDATA)>');
   XMLLines.add('<!ELEMENT CodeLink (LinkHint, LinkLink)+>');
   XMLLines.add('<!ELEMENT LinkName (#PCDATA)>');
   XMLLines.add('<!ELEMENT LinkHint (#PCDATA)>');
   XMLLines.add('<!ELEMENT LinkLink (#PCDATA)>');
   XMLLines.add(']>');
   XMLLines.add('<SchnipselCode>');
   for i:=0 to XMLLines.count-1 do
    XMLFile.add(XMLLines[i]);
   XMLLines.clear;
   for ExpCount:=0 to ExportList.Count-1 do
    begin
     Pbar.Position:=Pbar.Position+1;
     Pbar.Update;
     sleep(500);
     stra:=ExportList[ExpCount].split('_');
     XMLLines.clear;
     XMLLines.add('<CodeEntry>');
     try
      SQLQuery1.SQL.Text := 'SELECT cn.id as reacid, cn.lang_id as Langid ,cn.type_id as Typeid ,c.schnipsel as Ctext, cn.Schnipsel_Name as Cname from schnipsel_names as cn left join schnipsel_codes as c on c.schnipsel_id=cn.id where c.id=:Code_id';
      SQLQuery1.Params.ParamByName('Code_id').asInteger:=strtoint(stra[0]);
      SQLQuery1.Open;
      reacid:=SQLQuery1.FieldByName('reacid').AsInteger;
      Lid:=SQLQuery1.FieldByName('Langid').AsInteger;
      Tid:=SQLQuery1.FieldByName('Typeid').AsInteger;
      XMLLines.add('<CodeName>'+stringsreplace(SQLQuery1.FieldByName('Cname').AsString,['"','''','<','>','&'],['&quot;','&apos;','&lt;','&gt;','&amp;'],[rfReplaceAll])+'</CodeName>');
      CodeLines:=Tstringlist.create;
      CodeLines.LoadFromStream(sqlquery1.CreateBlobStream(SQLQuery1.Fields[3],bmread));
      SQLQuery1.Close;
     except
      on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
     end;
     try
      SQLQuery1.SQL.Text := 'SELECT l.Language as Lname ,l.Lang_short as Lshort ,t.TypeName as Tname from schnipsel_language as l join schnipsel_types as t where t.id=:T_id and l.id=:L_id';
      SQLQuery1.Params.ParamByName('L_id').asString:=inttostr(Lid);
      SQLQuery1.Params.ParamByName('T_id').asString:=inttostr(Tid);
      SQLQuery1.Open;
      XMLLines.add('<CodeLanguage>'+stringsreplace(SQLQuery1.FieldByName('Lname').AsString+' ('+SQLQuery1.FieldByName('Lshort').AsString,['"','''','<','>','&'],['&quot;','&apos;','&lt;','&gt;','&amp;'],[rfReplaceAll])+')</CodeLanguage>');
      XMLLines.add('<CodeType>'+stringsreplace(SQLQuery1.FieldByName('Tname').AsString,['"','''','<','>','&'],['&quot;','&apos;','&lt;','&gt;','&amp;'],[rfReplaceAll])+'</CodeType>');
      XMLLines.add('<CodeTXT>');
      for i:=0 to CodeLines.count-1 do
       XMLLines.add(stringsreplace(CodeLines[i],['"','''','<','>','&'],['&quot;','&apos;','&lt;','&gt;','&amp;'],[rfReplaceAll]));
      XMLLines.add('</CodeTXT>');
      SQLQuery1.Close;
     except
      on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
     end;
     CodeLines.free;
     XMLLines.add('<CodeAppend>');
     if(stra[1]='1') then
      begin
       try
        SQLQuery1.SQL.Text := 'SELECT required_name, required_hint,required_link from schnipsel_required where code_id=:Cid';
        SQLQuery1.Params.ParamByName('Cid').asInteger:=reacid;
        SQLQuery1.Open;
        while not SQLQuery1.EOF do
         begin
          XMLLInes.add('<CodeRequired>');
          XMLLines.add('<RequiredName>'+stringsreplace(SQLQuery1.FieldByName('required_name').AsString,['"','''','<','>','&'],['&quot;','&apos;','&lt;','&gt;','&amp;'],[rfReplaceAll])+'</RequiredName>');
          XMLLines.add('<RequiredHint>'+stringsreplace(SQLQuery1.FieldByName('required_hint').AsString,['"','''','<','>','&'],['&quot;','&apos;','&lt;','&gt;','&amp;'],[rfReplaceAll])+'</RequiredHint>');
          XMLLines.add('<RequiredLink>'+stringsreplace(SQLQuery1.FieldByName('required_link').AsString,['"','''','<','>','&'],['&quot;','&apos;','&lt;','&gt;','&amp;'],[rfReplaceAll])+'</RequiredLink>');
          XMLLines.add('</CodeRequired>');
          SQLQuery1.next;
         end;
        SQLQuery1.Close;
       except
        on E: ESQLDatabaseError do
             messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
       end;
      end
     else
      begin
       XMLLInes.add('<CodeRequired>');
       XMLLines.add('<RequiredName></RequiredName>');
       XMLLines.add('<RequiredHint></RequiredHint>');
       XMLLines.add('<RequiredLink></RequiredLink>');
       XMLLines.add('</CodeRequired>');
      end;
     if(stra[2]='1') then
      begin
       try
        SQLQuery1.SQL.Text := 'SELECT author, comment from schnipsel_comments where code_id=:Cid';
        SQLQuery1.Params.ParamByName('Cid').asInteger:=reacid;
        SQLQuery1.Open;
        while not SQLQuery1.EOF do
         begin
          XMLLInes.add('<CodeComment>');
          XMLLines.add('<CommentAuthor>'+stringsreplace(SQLQuery1.FieldByName('author').AsString,['"','''','<','>','&'],['&quot;','&apos;','&lt;','&gt;','&amp;'],[rfReplaceAll])+'</CommentAuthor>');
          XMLLines.add('<CommentComment>'+stringsreplace(SQLQuery1.FieldByName('comment').AsString,['"','''','<','>','&'],['&quot;','&apos;','&lt;','&gt;','&amp;'],[rfReplaceAll])+'</CommentComment>');
          XMLLines.add('</CodeComment>');
          SQLQuery1.next;
         end;
        SQLQuery1.Close;
       except
        on E: ESQLDatabaseError do
             messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
       end;
      end
     else
      begin
       XMLLInes.add('<CodeComment>');
       XMLLines.add('<CommentAuthor></CommentAuthor>');
       XMLLines.add('<CommentComment></CommentComment>');
       XMLLines.add('</CodeComment>');
      end;
     if(stra[3]='1') then
      begin
       try
        SQLQuery1.SQL.Text := 'SELECT link_text, link_url from schnipsel_links where code_id=:Cid';
        SQLQuery1.Params.ParamByName('Cid').asInteger:=reacid;
        SQLQuery1.Open;
        while not SQLQuery1.EOF do
         begin
          XMLLInes.add('<CodeLinks>');
          XMLLines.add('<LinkHint>'+stringsreplace(SQLQuery1.FieldByName('link_text').AsString,['"','''','<','>','&'],['&quot;','&apos;','&lt;','&gt;','&amp;'],[rfReplaceAll])+'</LinkHint>');
          XMLLines.add('<LinkLink>'+stringsreplace(SQLQuery1.FieldByName('link_url').AsString,['"','''','<','>','&'],['&quot;','&apos;','&lt;','&gt;','&amp;'],[rfReplaceAll])+'</LinkLink>');
          XMLLines.add('</CodeLinks>');
          SQLQuery1.next;
         end;
        SQLQuery1.Close;
       except
        on E: ESQLDatabaseError do
             messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
       end;
      end
     else
      begin
       XMLLInes.add('<CodeLinks>');
       XMLLines.add('<LinkHint></LinkHint>');
       XMLLines.add('<LinkLink></LinkLink>');
       XMLLines.add('</CodeLinks>');
      end;
     XMLLines.add('</CodeAppend>');
     XMLLines.add('</CodeEntry>');
     for i:=0 to XMLLines.count-1 do
      XMLFile.add(XMLLines[i]);
    end;
   XMLFile.add('</SchnipselCode>');
   XMLFile.SaveToFile(ExportSaveDialog.filename);
   XMLFile.free;
   XMLLines.free;
   Pbar.Position:=0;
   openurl(ExportSaveDialog.filename);
  end;
end;


Procedure TSchnipselMainForm.CodeEntryClick(Sender: Tobject);
var s   : string;
    i,j : integer;
begin
 s:=(Sender as TstaticText).name;
 s:=copy(s,pos('_',s)+1,length(s));
 i:=strtoint(s);
 Selected_Code_Id:=i;
 Selected_Version_ID:=0;
 for j:=Requires_Panel.ControlCount-1 downto 0 do
  Requires_Panel.Controls[j].free;
 for j:=Comment_Panel.ControlCount-1 downto 0 do
  Comment_Panel.Controls[j].free;
 for j:=Links_Panel.ControlCount-1 downto 0 do
  Links_Panel.Controls[j].free;
 for j:=Code_Tabsheet.controlcount-1 downto 0 do
  if ((Code_Tabsheet.controls[j] is Tstatictext) and (Code_Tabsheet.controls[j].name <> 'CodeVersion')) then
   Code_Tabsheet.controls[j].free;
 CodeMemo.Clear;
 showCodeEntry(i);
end;


Procedure TSchnipselMainForm.Ver_BtnClick(Sender: Tobject);
var s   : string;
    i,j : integer;
begin
 s:=(Sender as TstaticText).name;
 s:=copy(s,pos('_',s)+1,length(s));
 i:=strtoint(s);
 for j:=WorkSpace_Panel.ControlCount-1 downto 0 do
  if pos('BtnCode_',WorkSpace_Panel.controls[j].name) > 0 then
   WorkSpace_Panel.controls[j].free;
 showCodeEntry(i);
end;


Procedure TSchnipselMainForm.ShowCodeEntry(cid : integer);
var Btn_left : integer;
    C_id     : integer;
    Vttip    : string;
    Ver_Btn  : TstaticText;
    MemoStream : Tstream;
begin
 try
  LTPanel.visible:=true;
  Code_PageControl.ActivePage:=Code_TabSheet;
  SQLQuery1.SQL.Text := 'select sc.id as C_id,sc.version as Version,sc.author as Aname,sc.schnipsel as Scode,sn.Schnipsel_Name as Sname from schnipsel_codes as sc inner join schnipsel_names as sn on sc.schnipsel_id=sn.id and sc.schnipsel_id=:S_id order by sc.id DESC';
  SQLQuery1.Params.ParamByName('S_id').asInteger:=Selected_Code_ID;
  SQLQuery1.Open;
  Btn_left:=490;
  while not SQLQuery1.EOF do
   begin
    C_id:=SQLQuery1.FieldByName('C_id').AsInteger;
    if ((cid = C_id) or (SQLQuery1.RowsAffected=1) {or (Selected_Version_ID=0)}) then
     begin
      Selected_Version_ID:=C_id;
      Vttip:=Centrystr1+SQLQuery1.FieldByName('Version').AsString+' ('+(SQLQuery1.FieldByName('Aname').AsString)+' )';
      CodeVersion.caption:=Vttip;
      WorkSpace_StatusBar.Panels[1].text:=SQLQuery1.FieldByName('Sname').AsString;
      Requires_Codename.caption:=SQLQuery1.FieldByName('Sname').AsString;
      Comments_Codename.caption:=SQLQuery1.FieldByName('Sname').AsString;
      Links_Codename.caption:=SQLQuery1.FieldByName('Sname').AsString;
      CodeMemo.clear;
      MemoStream:=sqlquery1.CreateBlobStream(SQLQuery1.Fields[3],bmread);
      CodeMemo.lines.LoadFromStream(MemoStream);
      MemoStream.Free;
     end
    else
     begin
      Ver_Btn:=Tstatictext.create(nil);
      Ver_Btn.BorderStyle:=sbsSingle;
      Ver_Btn.setbounds(Btn_left,65,20,16);
      Ver_Btn.Alignment:=taCenter;
      Ver_Btn.ShowHint:=true;
      Ver_Btn.onMouseEnter:=@TextFontLink;
      Ver_Btn.onMouseLeave:=@TextFontNormal;;
      Vttip:=Centrystr1+' '+SQLQuery1.FieldByName('Version').AsString+' ('+(SQLQuery1.FieldByName('Aname').AsString)+' )';
      Ver_Btn.hint:=Vttip;
      Ver_Btn.Name:='BtnCode_'+inttostr(C_id);
      Ver_Btn.caption:=CEntryStr2;
      Ver_Btn.onClick:=@Ver_BtnClick;
      Ver_Btn.Font.style:=Ver_Btn.Font.style+[fsBold];
      Ver_Btn.Parent:=Code_TabSheet;
      dec(Btn_left,20);
     end;
    SQLQuery1.Next;
   end;
  SQLQuery1.Close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 try
  SQLQuery1.SQL.Text := 'select id from schnipsel_favorites where schnipsel_id=:S_id';
  SQLQuery1.Params.ParamByName('S_id').asInteger:=Selected_Code_ID;
  SQLQuery1.Open;
  if (SQLQuery1.RowsAffected > 0) then
   begin
    CodeFavBtn.ImageIndex:=29;
    CodeFavBtn.Hint:=Centrystr7;
   end
  else
   begin
    CodeFavBtn.ImageIndex:=28;
    CodeFavBtn.Hint:=Centrystr6;
   end;
  SQLQuery1.close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 try
  SQLQuery1.SQL.Text := 'select id from schnipsel_bookmarks where schnipsel_id=:S_id';
  SQLQuery1.Params.ParamByName('S_id').asInteger:=Selected_Code_ID;
  SQLQuery1.Open;
  if (SQLQuery1.RowsAffected > 0) then
   begin
    CodeBMBtn.ImageIndex:=27;
    CodeBMBtn.Hint:=Centrystr5;
   end
  else
   begin
    CodeBMBtn.ImageIndex:=26;
    CodeBMBtn.Hint:=Centrystr4;
   end;
  SQLQuery1.close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 LangTypesList.visible:=false;
 LTPanel.visible:=false;
 Code_PageControl.visible:=true;
end;


Procedure TSchnipselMainForm.Expand_ImageClick(Sender: Tobject);
var s      : string;
    i      : integer;
begin
 for i:=LTPanel.ControlCount-1 downto 0 do
  begin
   if((LTPanel.Controls[i] is TImage) and ((LTPanel.Controls[i] as TImage).visible=false)) then
    LTPanel.controls[i].free;
  end;
 s:=copy(((Sender as TImage).Name),pos('_',((Sender as TImage).Name))+1,length(((Sender as TImage).Name)));
 i:=strtoint(s);
 if (Expand_Typelist_ID[i]='1') then Expand_Typelist_ID[i]:='0'
 else Expand_Typelist_ID[i]:='1';
 ShowTypeCodeList(Selected_Lang);
end;


Procedure TSchnipselMainForm.Delete_ImageClick(Sender: Tobject);
var i  : integer;
    sa : array of string;
begin
 if(MessageDlgPos(Typeliststr3,mtconfirmation,
                   [mbYes,mbNo],0,round(left+(width/2)),round(top+(height/2))) = mrYes) then
  begin
   sa:=(Sender as TImage).name.split('_');
   i:=strtoint(sa[1]);
   try
    SQLQuery1.SQL.Text := 'delete from schnipsel_favorites where schnipsel_id=:Code_id';
    SQLQuery1.Params.ParamByName('Code_id').asInteger:=i;
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
          messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   try
    SQLQuery1.SQL.Text := 'delete from schnipsel_bookmarks where schnipsel_id=:Code_id';
    SQLQuery1.Params.ParamByName('Code_id').asInteger:=i;
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
          messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   try
    SQLQuery1.SQL.Text := 'delete from schnipsel_required where required_id=:Code_id';
    SQLQuery1.Params.ParamByName('Code_id').asInteger:=i;
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
   except
     on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   try
    SQLQuery1.SQL.Text := 'delete from schnipsel_codes where schnipsel_id=:Code_id';
    SQLQuery1.Params.ParamByName('Code_id').asInteger:=i;
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
          messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   try
    SQLQuery1.SQL.Text := 'delete from schnipsel_names where id=:Code_id';
    SQLQuery1.Params.ParamByName('Code_id').asInteger:=i;
    SQLQuery1.ExecSQL;
    SQLTransaction1.Commit;
   except
    on E: ESQLDatabaseError do
          messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
   Selected_Code_ID:=0;
   Selected_Version_ID:=0;
   for i:=LTPanel.ControlCount-1 downto 0 do
    if(LTPanel.Controls[i] is TImage) and (pos('EXPi_delete',LTPanel.Controls[i].name) > 0) then
     LTPanel.controls[i].free;
   (Sender as TImage).visible:=false;
   (Sender as TImage).name:='EXPi_delete';
   ShowTypeCodeList(Selected_Lang);
  end;
end;


Procedure TSchnipselMainForm.ShowTypeCodeList(Lang_id : integer);
var i,spacer       : integer;
    TEntry,
    CEntry         : Tstatictext;
    Centry_line    : TdividerBevel;
    Entry_Image,
    Expand_Image,
    Delete_Image   : TImage;
    stra           : array of string;

begin
 CodesList.clear;
 TypesList.clear;
 LangTypesList.visible:=false;
 try
  SQLQuery1.SQL.Text := 'SELECT a.typename as TName, b.type_id as Tid FROM schnipsel_types a LEFT JOIN schnipsel_names b on b.lang_id=:L_id AND a.id=b.type_id group by a.id';
  SQLQuery1.Params.ParamByName('L_id').asInteger:= Lang_id;
  SQLQuery1.Open;
  while not SQLQuery1.EOF do
   begin
    Typeslist.add(SQLQuery1.FieldByName('TName').AsString+'|'+SQLQuery1.FieldByName('Tid').AsString);
    SQLQuery1.Next;
   end;
  SQLQuery1.Close;
 except
  on E: ESQLDatabaseError do
         messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
 end;
 spacer:=12;
 for i:=LTPanel.ControlCount-1 downto 0 do
  begin
   if(LTPanel.Controls[i] is TImage) and (pos('EXPi_',LTPanel.Controls[i].name) > 0) then
    LTPanel.controls[i].visible:=false
   else
    LTPanel.controls[i].free;
  end;
 for i:=0 to TypesList.count-1 do
  begin
   stra:=TypesList[i].split('|');
   if(length(Expand_Typelist_ID) < i) then Expand_Typelist_ID+='0';
   Expand_Image:=TImage.create(nil);
   Expand_Image.setbounds(10,spacer+20,16,16);
   Expand_Image.hint:=Typeliststr1;
   Expand_Image.showhint:=true;
   Expand_Image.name:='EXPi_'+inttostr(i+1);
   if(Expand_Typelist_ID[i+1]='0') then
    ImageList_white.GetBitmap(10, Expand_Image.Picture.Bitmap)
   else
    ImageList_white.GetBitmap(11, Expand_Image.Picture.Bitmap);
   if(stra[1]='') then   // No Code Entrys found for this Type
    begin
     Expand_TypeList_ID[i+1]:='0';
     ImageList_white.GetBitmap(12, Expand_Image.Picture.Bitmap);
    end
   else
    Expand_Image.onclick:=@Expand_ImageClick;
   Expand_Image.onMouseEnter:=@LinkImage;
   Expand_Image.Parent:=LTPanel;
   TEntry:=Tstatictext.Create(nil);
   TEntry.setbounds(34,spacer+20,360,16);
   TEntry.Alignment:=taLeftJustify;
   TEntry.Font.style:=TEntry.Font.style+[fsBold];
   TEntry.Caption:=stra[0];
   TEntry.name:='TEntry_'+stra[1];
   TEntry.Parent:=LTPanel;
   inc(spacer,40);
   if (Expand_TypeList_ID[i+1]='1') then
    begin
     try
      SQLQuery1.SQL.Text := 'select Schnipsel_Name as CName, id as Cid from schnipsel_names where lang_id=:L_id and type_id=:T_id order by id DESC';
      SQLQuery1.Params.ParamByName('L_id').asInteger:= Lang_id;
      SQLQuery1.Params.ParamByName('T_id').asInteger:= strtoint(stra[1]);
      SQLQuery1.Open;
      while not SQLQuery1.EOF do
       begin
        Entry_Image:=TImage.create(nil);
        Entry_Image.setbounds(35,spacer+8,16,16);
        ImageList_white.GetBitmap(13, Entry_Image.Picture.Bitmap);
        Entry_Image.Parent:=LTPanel;
        CEntry:=Tstatictext.Create(nil);
        CEntry.Font:=Font;
        CEntry.setbounds(55,spacer+8,360,16);
        CEntry.Alignment:=taLeftJustify;
        CEntry.Caption:=SQLQuery1.FieldByName('CName').AsString;
        CEntry.name:='CEntry_'+SQLQuery1.FieldByName('Cid').AsString;
        Centry.showhint:=true;
        Centry.hint:=Typeliststr2;
        CEntry.onMouseEnter:=@TextFontLink;
        CEntry.onMouseLeave:=@TextFontNormal;
        Centry.OnClick:=@CodeEntryClick;
        CEntry.Parent:=LTPanel;
        if(Edit_Mode=true) then
         begin
          Centry_line:=TDividerBevel.create(nil);
          Centry_line.setbounds(35,spacer+30,400,15);
          CEntry_Line.BevelStyle:=bsLowered;
          Centry_Line.Parent:=LTPanel;
          Delete_Image:=TImage.create(nil);
          Delete_Image.setbounds(420,spacer+15,16,16);
          Delete_Image.hint:=Typeliststr3;
          Delete_Image.ShowHint:=true;
          Delete_Image.name:='DelImgCode_'+SQLQuery1.FieldByName('Cid').AsString;
          ImageList_white.GetBitmap(16, Delete_Image.Picture.Bitmap);
          Delete_Image.onclick:=@Delete_ImageClick;
          Delete_Image.onMouseEnter:=@LinkImage;
          Delete_Image.Parent:=LTPanel;
          inc(spacer,30);
         end;
        inc(spacer,25);
        SQLQuery1.Next;
       end;
     except
     on E: ESQLDatabaseError do
           messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
     end;
     SQLQuery1.Close;
   end;
  end;
 Code_PageControl.visible:=false;
 LangTypesList.visible:=true;
 LTPanel.visible:=true;
end;


procedure TSchnipselMainForm.EditorTB_SelectallBtnClick(Sender: TObject);
begin
 if(CodeEditor.SelAvail=true) then
  CodeEditor.BlockBegin:=CodeEditor.BlockEnd
 else
  CodeEditor.SelectAll;
end;

procedure TSchnipselMainForm.EDitorTB_SearchBtnClick(Sender: TObject);
begin
 FindDlg.Execute;
end;

procedure TSchnipselMainForm.EditorTB_ReplaceBtnClick(Sender: TObject);
begin
 ReplaceDlg.Execute;
end;


Procedure TSchnipselMainForm.MenuEntryClick(Sender: TObject);
var i : integer;
    s : string;
begin
 LTPanel.visible:=false;
 s:=(Sender as TStaticText).Caption;
 WorkSpace_StatusBar.Panels[0].text:=s;
 s:=(Sender as TStaticText).name;
 CodesList.clear;
 s:=copy(s,pos('_',s)+1,length(s));
 i:=strtoint(s);
 Selected_Lang:=i;
 Expand_TypeList_ID:='000';
 ShowTypeCodeList(i);
end;


procedure TSchnipselMainForm.SaveFont(FName: string; Section: string; smFont: TFont);
var schnipsel_ini : TiniFile;
begin
 schnipsel_ini:= TIniFile.Create(FName);
  try
    schnipsel_ini.WriteString(Section, 'Name', smFont.Name);
    schnipsel_ini.Writestring(Section, 'Color', ColorToString(smFont.Color));
    schnipsel_ini.WriteInteger(Section, 'Size', smFont.Size);
    schnipsel_ini.WriteBool(Section, 'Bold', (fsBold in smFont.Style));
    schnipsel_ini.WriteBool(Section, 'UnderLine', (fsUnderLine in smFont.Style));
    schnipsel_ini.WriteBool(Section, 'Italic', (fsItalic in smFont.Style));
  finally
    schnipsel_ini.Free;
  end;
end;


procedure TSchnipselMainForm.LoadFont(FName: string; Section: string; smFont: TFont);
var schnipsel_ini : TiniFile;
begin
 schnipsel_ini:= TIniFile.Create(FName);
  try
    smFont.Name:=schnipsel_ini.ReadString(Section, 'Name', smFont.Name);
    smFont.Color:=StringToColor(schnipsel_ini.ReadString(Section, 'Color', ColorToString(smFont.Color)));
    smFont.Size:=schnipsel_ini.ReadInteger(Section, 'Size', smFont.Size);
    smFont.Style:=([]);
    if(schnipsel_ini.ReadBool(Section,'Bold',False)) then
     smFont.Style:=smFont.Style+[fsBold];
    if(schnipsel_ini.ReadBool(Section,'UnderLine',False)) then
     smFont.Style:=smFont.Style+[fsUnderLine];
    if(schnipsel_ini.ReadBool(Section,'Italic',False)) then
     smFont.Style:=smFont.Style+[fsItalic];
  finally
    schnipsel_ini.Free;
  end;
end;


procedure TSchnipselMainForm.FormClose(Sender: TObject);
var i            : integer;
    EditorStream : TMemoryStream;
begin
 if((Edit_Code_ID > 0) or (CodeEditor.enabled=true)) then
  if(messageDlgPos(Editorstr7+slinebreak+Editorstr10,mtConfirmation,[mbYes,mbNo],0,
                   round(left+(width/2)),round(top+(height/2))) = mrNo) then
   begin
    if(CodeEditor.lines.Count > 1000) then
     begin
      messageDlgPos(Editorstr5+slinebreak+Editorstr6,mtWarning,[mbOK],0,round(left+(width/2)),round(top+(height/2)));
      for i:=CodeEditor.Lines.Count-1 downto 1000 do
       CodeEditor.Lines.Delete(i);
     end;
    if(Editor_Toolbar.enabled=true) then
     begin
      if(Edit_Code_ID=0) then
       begin
        try
         SQLQuery1.SQL.Text := 'update schnipsel_names set Schnipsel_Name=:Cname where id=:Code_id';
         SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
         SQLQuery1.Params.ParamByName('Cname').asString:=trim(Editor_Code_Name.text);
         SQLQuery1.ExecSQL;
         SQLTransaction1.Commit;
        except
         on E: ESQLDatabaseError do
               messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
        end;
        try
         if (Selected_Version_ID > 0) then         // Code Version Update
          begin
           SQLQuery1.SQL.Text := 'update schnipsel_codes set schnipsel_id=:Code_id, author=:Author, version=:Version,schnipsel=:Schnipsel where id=:To_id';
           SQLQuery1.Params.ParamByName('To_id').asInteger:=Selected_Version_ID;
          end
         else                                      // Code New Version
          SQLQuery1.SQL.Text := 'insert into schnipsel_codes (schnipsel_id,author,version,schnipsel) values(:Code_id,:Author,:Version,:Schnipsel)';
         SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
         SQLQuery1.Params.ParamByName('Version').asString:=trim(EditorTB_Version.text);
         SQLQuery1.Params.ParamByName('Author').asString:=trim(EditorTB_Author.text);
         EditorStream:=TMemoryStream.create;
         CodeEditor.lines.SaveToStream(EditorStream);
         SQLQuery1.ParamByName('Schnipsel').LoadFromStream(EditorStream, ftBlob);
         SQLQuery1.ExecSQL;
         SQLTransaction1.Commit;
         EditorStream.Free;
        except
         on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
        end;
        if(Selected_Version_ID=0) then             // New Code Version, WE NEED THE ID
         begin
          i:=0;
          try
           if(DBEngine='SQlite') then
            SQLQuery1.SQL.Text := 'SELECT last_insert_rowid() as Last_id from schnipsel_codes'
           else
            SQLQuery1.SQL.Text := 'SELECT LAST_INSERT_ID(Id) as Last_id from schnipsel_codes order by LAST_INSERT_ID(Id) desc limit 1';
           SQLQuery1.Open;
           i:=SQLQuery1.FieldByName('Last_id').AsInteger;
           SQLQuery1.Close;
          except
           on E: ESQLDatabaseError do
               messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
          end;
         end;
        if(i>0) then
         Selected_Version_ID:=i;
       end;
      if(Edit_Code_ID > 0) then         // New CodeEntry
       begin
        try
         SQLQuery1.SQL.Text := 'insert into schnipsel_codes (schnipsel_id,author,version,schnipsel) values(:Code_id,:Author,:Version,:Schnipsel)';
         SQLQuery1.Params.ParamByName('Code_id').asInteger:=Edit_Code_ID;
         SQLQuery1.Params.ParamByName('Version').asString:=trim(EditorTB_Version.text);
         SQLQuery1.Params.ParamByName('Author').asString:=trim(EditorTB_Author.text);
         EditorStream:=TMemoryStream.create;
         CodeEditor.lines.SaveToStream(EditorStream);
         SQLQuery1.ParamByName('Schnipsel').LoadFromStream(EditorStream, ftBlob);
         SQLQuery1.ExecSQL;
         SQLTransaction1.Commit;
         EditorStream.Free;
        except
         on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
        end;
        try
         SchnipselMainForm.SQLQuery1.SQL.Text := 'SELECT LAST_INSERT_ID(Id) as Last_id from schnipsel_codes order by LAST_INSERT_ID(Id) desc limit 1';
         SchnipselMainForm.SQLQuery1.Open;
         i:=SchnipselMainForm.SQLQuery1.FieldByName('Last_id').AsInteger;
         SchnipselMainForm.SQLQuery1.Close;
        except
         on E: ESQLDatabaseError do
             messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
        end;
        Selected_Code_ID:=Edit_Code_ID;
        Selected_Version_ID:=i;
        try
         SQLQuery1.SQL.Text := 'update schnipsel_names set Schnipsel_Name=:Cname where id=:Code_id';
         SQLQuery1.Params.ParamByName('Code_id').asInteger:=Selected_Code_ID;
         SQLQuery1.Params.ParamByName('Cname').asString:=trim(Editor_Code_Name.text);
         SQLQuery1.ExecSQL;
         SQLTransaction1.Commit;
        except
         on E: ESQLDatabaseError do
            messagedlgpos(E.Message,mtWarning,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
        end;
        Edit_Code_ID:=0;
       end;
     end;
    messagedlgpos(Editorstr11,mtInformation,[mbOk],0,round(left+(width/2)),round(top+(height/2)));
   end;
  SchnipselIniStorage.save;
  if(font_changed=true) then
   begin
    SaveFont(sysutils.GetEnvironmentVariable('localappdata')+DirectorySeparator+'Schnipsel'+DirectorySeparator+'Schnipsel.ini','ContentFont',Font);
    SaveFont(sysutils.GetEnvironmentVariable('localappdata')+DirectorySeparator+'Schnipsel'+DirectorySeparator+'Schnipsel.ini','MenuFont',SideMenu_Panel.Font);
    SaveFont(sysutils.GetEnvironmentVariable('localappdata')+DirectorySeparator+'Schnipsel'+DirectorySeparator+'Schnipsel.ini','CodeFont',CodeMemo.Font);
   end;
  Menu_Entrys.Free;
  CodesList.Free;
  TypesList.free;
  ExportList.free;
end;


end.

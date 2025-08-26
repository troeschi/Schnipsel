unit SettingsDlg;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Buttons,
  StdCtrls, ExtCtrls, DividerBevel;

type

  { TSettingsDialog }

  TSettingsDialog = class(TForm)
    Image1: TImage;
    RadioButton1: TRadioButton;
    RBbrown: TRadioButton;
    RBblue: TRadioButton;
    RBgreen: TRadioButton;
    RBred: TRadioButton;
    ScrollBox1: TScrollBox;
    Shape1: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Shape2: TShape;
    Shape20: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    StaticText1: TStaticText;
    DefaultFontBtn: TBitBtn;
    DividerBevel3: TDividerBevel;
    MenuFontBtn: TBitBtn;
    CloseBtn: TBitBtn;
    DividerBevel1: TDividerBevel;
    DividerBevel2: TDividerBevel;
    FontDialog1: TFontDialog;
    CodeFontBtn: TBitBtn;
    CodeSample: TStaticText;
    MenuTXT: TStaticText;
    CodeTXT: TStaticText;
    OkBtn: TBitBtn;
    Settings_PageControl: TPageControl;
    FontSettings: TTabSheet;
    HtmlExportSettings: TTabSheet;
    GeneralTXT: TStaticText;
    DefaultSample: TStaticText;
    MenuSample: TStaticText;
    procedure CodeFontBtnClick(Sender: TObject);
    procedure DefaultFontBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuFontBtnClick(Sender: TObject);
  private

  public

  end;

var
  SettingsDialog: TSettingsDialog;

implementation

{$R *.lfm}

uses MainForm, FileUtil, LazFileUtils;

{ TSettingsDialog }

procedure TSettingsDialog.DefaultFontBtnClick(Sender: TObject);
begin
 FontDialog1.font:=DefaultSample.font;
 if(FontDialog1.execute) then
  begin
   DefaultSample.font:=FontDialog1.font;
  end;
end;


procedure TSettingsDialog.FormCreate(Sender: TObject);
begin
 font:=SchnipselMainForm.Font;
 Settings_PageControl.font.style:=Settings_PageControl.font.style+[fsBold];
 FontSettings.font:=SchnipselMainForm.Font;
 HtmlExportSettings.font:=SchnipselMainForm.Font;
end;


procedure TSettingsDialog.FormShow(Sender: TObject);
var CSStemplates : TstringList;
    i            : integer;
    CSSImg       : Timage;
    CSSRbtn      : TradioButton;
    TTop         : integer;
begin
 case SchnipselMainForm.RBcolor of
  'red'   : RBred.checked:=true;
  'blue'  : RBblue.checked:=true;
  'green' : RBgreen.checked:=true;
  'brown' : RBbrown.checked:=true;
 end;
 for i:=Scrollbox1.ControlCount-1 downto 0 do
  Scrollbox1.Controls[i].free;
 try
  CSStemplates:=findAllFiles('Templates','*.css',false);
  TTop:=24;
  for i:=0 to CSStemplates.Count-1 do
   begin
    CSSRbtn:=TradioButton.Create(Nil);
    CSSRbtn.setbounds(24,TTop,200,19);
    CSSRbtn.Caption:=CSStemplates[i];
    CSSRbtn.name:='RBtn_'+inttostr(i);
    if(i=0) or (SchnipselMainForm.ExpCSS = CSSTemplates[i]) then
     CSSRbtn.checked:=true;
    CSSRbtn.Parent:=Scrollbox1;
    CSSImg:=Timage.Create(Nil);
    CSSImg.SetBounds(135,TTop+24,216,128);
    CSSImg.stretch:=true;
    CSSImg.Proportional:=true;
    CSSImg.Picture.LoadFromFile('Templates'+DirectorySeparator+'Images'+DirectorySeparator+ExtractFileNameOnly(CSSTemplates[i])+'.png');
    CSSImg.Parent:=Scrollbox1;
    inc(TTop,170);
   end;
 finally
  CSStemplates.free;
 end;
 repaint;
end;


procedure TSettingsDialog.CodeFontBtnClick(Sender: TObject);
begin
 FontDialog1.font:=CodeSample.font;
 if(FontDialog1.execute) then
  begin
   CodeSample.font:=FontDialog1.font;
  end;
end;


procedure TSettingsDialog.MenuFontBtnClick(Sender: TObject);
begin
 FontDialog1.font:=MenuSample.font;
 if(FontDialog1.execute) then
  begin
   MenuSample.font:=FontDialog1.font;
  end;
end;


end.


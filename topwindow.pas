unit TopWindow;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls,
  Menus, RichMemo, Types;

type

  { TTopForm }

  TTopForm = class(TForm)
    TopMemoSelectAll: TMenuItem;
    TopMemoCopy: TMenuItem;
    TopMemoPopup: TPopupMenu;
    TopCloseBtn: TBitBtn;
    TopCodeMemo: TRichMemo;
    CodeName: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure TopCloseBtnClick(Sender: TObject);
    procedure TopCodeMemoMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure TopMemoCopyClick(Sender: TObject);
    procedure TopMemoSelectAllClick(Sender: TObject);
  private

  public

  end;

var
  TopForm: TTopForm;

implementation

{$R *.lfm}

uses windows;

{ TTopForm }

procedure TTopForm.TopCloseBtnClick(Sender: TObject);
begin
 TopForm.hide;
end;


procedure TTopForm.TopCodeMemoMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var key : word;
begin
 if (WheelDelta > 0) then
  key:=VK_Prior
 else
  Key:=VK_Next;
 Handled:=True;
 PostMessage(TopCodeMemo.Handle, WM_KEYDOWN, Key, 0);
end;


procedure TTopForm.TopMemoCopyClick(Sender: TObject);
begin
 TopCodeMemo.CopyToClipboard;
end;


procedure TTopForm.TopMemoSelectAllClick(Sender: TObject);
begin
 if (TopCodeMemo.sellength > 0) then
  TopCodeMemo.Sellength:=0
 else
 TopCodeMemo.SelectAll;
end;


procedure TTopForm.FormCreate(Sender: TObject);
begin
 TopCodeMemo.Transparent:=true;
 Top:=0;
 Left:=screen.Desktopwidth-width;
end;

end.


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

// Form of send-to-TopWindow

unit TopWindow;

{$mode ObjFPC}{$H+}

interface

uses
 {$IFDEF UNIX}
  keysym,messages,
 {$ENDIF}
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
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
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

uses
  {$IFNDEF UNIX}
  windows,
  {$ENDIF}
  LCLTranslator, LCLIntf;

{ TTopForm }


procedure TTopForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if(key=112) then
  if(setdefaultlang('')='de') then
   openurl('Schnipsel.chm')
  else
   openurl('Schnipsel_'+setdefaultlang('')+'.chm');
end;


procedure TTopForm.TopCloseBtnClick(Sender: TObject);
begin
 TopForm.hide;
end;


procedure TTopForm.TopCodeMemoMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var key : word;
begin
 {$IFNDEF UNIX}
 if (WheelDelta > 0) then
  key:={$IFNDEF UNIX}VK_Prior{$ELSE}XK_PRIOR{$ENDIF}
 else
  Key:={$IFNDEF UNIX}VK_Next{$ELSE}XK_NEXT{$ENDIF};
 Handled:=True;
 PostMessage(TopCodeMemo.Handle, WM_KEYDOWN, Key, 0);
 {$ENDIF}
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
 {$IFDEF UNIX}
 TopCodeMemo.ScrollBars:=ssAutoVertical;
 {$ENDIF}
end;

end.


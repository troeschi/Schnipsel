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

// Main program / project-file of the application

program Schnipsel;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,graphics,dialogs,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, pack_powerpdf, lazcontrols, lhelpcontrolpkg,
  MainForm, uDarkStyleParams,
  uDarkStyleSchemes, uMetaDarkStyle,
  {$IFNDEF UNIX}
  Windows, Win32Proc, Registry,
  {$ENDIF}
  Languages, Required,
  CodeComment, CodeLinks, NewEntry,
  CodeTypes, Uexportdlg, Uexportpdfdlg, Translate_strings, TopWindow,
  Udbconfigdlg, SettingsDlg, DBsearch;

{$R *.res}

{$IFDEF UNIX}
function IsDarkTheme: boolean;
const
  cMax = $A0;
var
  N: TColor;
begin
  N:= ColorToRGB(clWindow);
  Result:= (Red(N)<cMax) and (Green(N)<cMax) and (Blue(N)<cMax);
end;
{$ENDIF}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;

  { - DARK MODE START - }
  PreferredAppMode := pamForceDark;
  {$IFNDEF UNIX}
  uMetaDarkStyle.ApplyMetaDarkStyle(DefaultDark);
  {$ELSE}
  if(not isDarkTheme) then
   begin
    showmessage('This App only works in Dark Mode!');
    exit;
   end;
  {$ENDIF}
  { -  DARK MODE END  - }

  {$PUSH}{$WARN 5044 OFF}
  Application.MainFormOnTaskbar:=True;
  {$POP}
  Application.Initialize;
  Application.CreateForm(TSchnipselMainForm, SchnipselMainForm);
  Application.CreateForm(TNewCategorieDlg, NewCategorieDlg);
  Application.CreateForm(TRequiredDlg, RequiredDlg);
  Application.CreateForm(TCommentDlg, CommentDlg);
  Application.CreateForm(TLinkDlg, LinkDlg);
  Application.CreateForm(TNewCodeEntryDlg, NewCodeEntryDlg);
  Application.CreateForm(TNewTypeDlg, NewTypeDlg);
  Application.CreateForm(TExportDlg, ExportDlg);
  Application.CreateForm(TExportPDFDlg, ExportPDFDlg);
  Application.CreateForm(TTopForm, TopForm);
  Application.CreateForm(TDBConfigDlg, DBConfigDlg);
  Application.CreateForm(TSettingsDialog, SettingsDialog);
  Application.CreateForm(TDBsearchDlg, DBsearchDlg);
  Application.Run;
end.


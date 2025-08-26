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
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, pack_powerpdf, lazcontrols, lhelpcontrolpkg,
MainForm, uDarkStyleParams,
  uDarkStyleSchemes, uMetaDarkStyle, Windows, Win32Proc, Registry,
Languages, Required,
  CodeComment, CodeLinks, NewEntry,
CodeTypes, Uexportdlg, Uexportpdfdlg, Translate_strings, TopWindow,
Udbconfigdlg, SettingsDlg;

{$R *.res}


begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;

  { - DARK MODE START - }
  // By default this is set to pamForceLight
  PreferredAppMode := pamForceDark;
  //  uMetaDarkStyle.ApplyMetaDarkStyle(DefaultDark);
  // This doesn't work if the above is set to pamForceLight
  uMetaDarkStyle.ApplyMetaDarkStyle(DefaultDark);
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
  Application.Run;
end.


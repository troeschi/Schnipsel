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
Udbconfigdlg;

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
  Application.Run;
end.


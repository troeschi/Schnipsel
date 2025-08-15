unit Uexportpdfdlg;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls;

type

  { TExportPDFDlg }

  TExportPDFDlg = class(TForm)
    CloseBtn: TBitBtn;
    OkBtn: TBitBtn;
    ExpPDFOutline: TCheckBox;
    ExpPDFSubject: TLabeledEdit;
    ExpPDFKeywords: TLabeledEdit;
    ExpPDFocop: TCheckBox;
    ExpPDFAuthor: TLabeledEdit;
    PDFGroupBox: TGroupBox;
    ExpPDFTitle: TLabeledEdit;
  private

  public

  end;

var
  ExportPDFDlg: TExportPDFDlg;

implementation

{$R *.lfm}

end.


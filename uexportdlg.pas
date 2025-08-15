unit Uexportdlg;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TExportDlg }

  TExportDlg = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ExportRequired: TCheckBox;
    ExportComments: TCheckBox;
    ExportLinks: TCheckBox;
    GroupBox1: TGroupBox;
    CodeName: TStaticText;
  private

  public

  end;

var
  ExportDlg: TExportDlg;

implementation

{$R *.lfm}

end.


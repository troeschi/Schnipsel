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

// PDF export-Form (Window) of the application

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
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  ExportPDFDlg: TExportPDFDlg;

implementation

{$R *.lfm}

uses MainForm;

{ TExportPDFDlg }

procedure TExportPDFDlg.FormCreate(Sender: TObject);
begin
 PDFGroupBox.Font.style:=PDFGroupBox.Font.style+[fsBold];
 ExpPDFTitle.Font:=SchnipselMainForm.Font;
 ExpPDFAuthor.Font:=SchnipselMainForm.Font;
 ExpPDFSubject.Font:=SchnipselMainForm.Font;
 ExpPDFKeywords.Font:=SchnipselMainForm.Font;
 ExpPDFOutLine.Font:=SchnipselMainForm.Font;
 ExpPDFocop.Font:=SchnipselMainForm.Font;
end;

end.


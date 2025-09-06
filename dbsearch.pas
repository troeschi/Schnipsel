unit DBsearch;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls;

type

  { TDBsearchDlg }

  TDBsearchDlg = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    SearchEdit: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  DBsearchDlg: TDBsearchDlg;

implementation

{$R *.lfm}

uses MainForm;


{ TDBsearchDlg }

procedure TDBsearchDlg.FormCreate(Sender: TObject);
begin
 Font:=SchnipselMainForm.font;
 GroupBox1.Font.style:=GroupBox1.Font.style+[fsBold];
 SearchEdit.EditLabel.Font.style:=SearchEdit.EditLabel.Font.style+[fsBold];
 SearchEdit.Font.style:=SearchEdit.Font.style-[fsBold];
end;

end.


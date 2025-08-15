unit Translate_strings;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

Resourcestring DataBaseErrorStr = 'Cant Connect to Database. Edit or delete Schnipsel.ini for new Configuration!';
Resourcestring ConnectionOK ='Connection to MySQL or MariaDB database "Schnipsel" = OK!';
Resourcestring InstallDBstr ='Install Database';
Resourcestring SCHVersion   ='Version:';
Resourcestring WrittenStr   ='Written by A.Trösch';
Resourcestring LicenseStr   ='GNU Lesser General Public License v3';
Resourcestring Used1Str     ='Written in Object Pascal using FPC and Lazarus';
Resourcestring Used2Str     ='Dark-Theme by Alexander Koblov: metadarkstyle';
Resourcestring Used3Str     ='PDF-Export written using PowerPDF by Takezou';
Resourcestring Used1Lnk     ='https://www.lazarus-ide.org/';
Resourcestring Used2Lnk     ='https://github.com/zamtmn/metadarkstyle';
Resourcestring Used3Lnk     ='https://github.com/altec-sistemas/powerpdf';

Resourcestring SearchNames  ='Search in Names:';
Resourcestring SearchCodes  ='Search in Codes:';

Resourcestring ExportstrXML ='XML-Export';
Resourcestring ExportstrPDF ='PDF-Export';
Resourcestring ExportstrHTML='HTML-Export';

Resourcestring Favorites    ='Favorites:';
Resourcestring Bookmarks    ='Bookmarks:';
Resourcestring PanelEntrys  ='Entrys:';
Resourcestring Panel0Entrys ='No Entrys';

Resourcestring Replacestr1  ='Es wurden ersetzt ';
Resourcestring Replacestr2  =' Vorkommnisse.';
Resourcestring Replacestr3  ='Dieses_Vorkommnis_ersetzen?';
Resourcestring Replacestr4  ='Nicht gefunden : ';

Resourcestring Requiredstr1 ='> Not in Schnipsel <';
Resourcestring Requiredstr2 ='> Select <';

Resourcestring Exportstr1   ='Delete from Exportlist?';
Resourcestring Exportstr2   ='Code: ';
Resourcestring Exportstr3   ='Code is allready in Exportlist!';
Resourcestring Exportstr4   =' (with required)';
Resourcestring Exportstr5   =' (with comments)';
Resourcestring Exportstr6   =' (with links)';
Resourcestring Exportstr7   ='Language: ';
Resourcestring Exportstr8   ='Type: ';
Resourcestring Exportstr9   ='Required for Code:';
Resourcestring Exportstr10  ='Name: ';
Resourcestring Exportstr11  ='Description: ';
Resourcestring Exportstr12  ='Url: ';
Resourcestring Exportstr13  ='Comments:';
Resourcestring Exportstr14  ='Author: ';
Resourcestring Exportstr15  ='Comment: ';
Resourcestring Exportstr16  ='Links:';
Resourcestring Exportstr17  ='Link Description: ';
Resourcestring Exportstr18  ='Url: ';
Resourcestring Exportstr19  ='DD.MM.YYYY';
Resourcestring Exportstr20  ='Required';
Resourcestring Exportstr21  ='Comments';
Resourcestring Exportstr22  ='Links';

Resourcestring Editorstr1   ='Version';
Resourcestring Editorstr2   ='Author';
Resourcestring Editorstr3   ='AUTHOR';
Resourcestring Editorstr4   ='VERSION';
Resourcestring Editorstr5   ='To Many Lines';
Resourcestring Editorstr6   ='Only the first 1000 Lines will be saved!';
Resourcestring Editorstr7   ='Code in Editor not saved!';
Resourcestring Editorstr8   ='Load this Code anyway?';
Resourcestring Editorstr9   ='New Code anyway?';
Resourcestring Editorstr10  ='Close anyway?';
Resourcestring Editorstr11  ='Code saved!';

Resourcestring Centrystr1   ='Version: ';
Resourcestring Centrystr2   ='V';
Resourcestring Centrystr3   ='No Link submitted';
Resourcestring Centrystr4   ='Mark as Bookmark';
Resourcestring Centrystr5   ='Delete Bookmark';
Resourcestring Centrystr6   ='Mark as Favorite';
Resourcestring Centrystr7   ='Delete Favorite';

Resourcestring Typeliststr1 ='Fold / unfold list';
Resourcestring Typeliststr2 ='Click to show code entry';
Resourcestring Typeliststr3 ='Delete this code entry and versions of it?';
Resourcestring Typeliststr4 ='Delete Code Version Entry?';

Resourcestring Dlgstr1      ='No Entry Selected';
Resourcestring Dlgstr2      ='Delete Entry?';
Resourcestring Dlgstr3      ='New Name cant be empty!';
Resourcestring Dlgstr4      ='Move Code Entrys from ';
Resourcestring Dlgstr5      =' to ';
Resourcestring Dlgstr6      =' and delete ';
Resourcestring Dlgstr7      =' ?';
Resourcestring Dlgstr8      ='Delete all Code Entrys in ';


implementation

end.

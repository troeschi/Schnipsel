DROP TABLE IF EXISTS `schnipsel_language`;
CREATE TABLE `schnipsel_language` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Language` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Lang_short` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO schnipsel_language VALUES("3","Pascal","Pas"),
("20","Linux","LX");

DROP TABLE IF EXISTS `schnipsel_bookmarks`;
CREATE TABLE `schnipsel_bookmarks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `schnipsel_id` int NOT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `schnipsel_favorites`;
CREATE TABLE `schnipsel_favorites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `schnipsel_id` int NOT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `schnipsel_codes`;
CREATE TABLE `schnipsel_codes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `schnipsel_id` int NOT NULL,
  `version` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `schnipsel` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO schnipsel_codes VALUES("45","40","1.0","A.Trösch",
"procedure TSchnipselMainForm.CodeMemoMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled : Boolean);
var key : word;
begin
 if (WheelDelta > 0) then
  key:=VK_Prior
 else
  Key:=VK_Next;
 Handled:=True;
 PostMessage(CodeMemo.Handle, WM_KEYDOWN, Key, 0);
end;    "
),
("48","42","1.0","A.Trösch",
"XML escape characters

There are only five:

\"   &quot;
'   &apos;
<   &lt;
>   &gt;
&   &amp;

Escaping characters depends on where the special character is used.

Salution:
stringsreplace(aStr,['\"','''','<','>','&'],['&quot;','&apos;','&lt;','&gt;','&amp;'],[rfReplaceAll])
"
),
("49","43","1.0","Ravi Saive",
"If OpenSSL not installed, you can run the following command to install OpenSSL in Linux.

$ sudo apt install openssl    [On Debian/Ubuntu/Mint]
$ sudo yum install openssl    [On RHEL/CentOS/Fedora]

Generate OpenSSL Private Key

$ openssl genrsa -out ubuntu_server.key

Generate Certificate Signing Request

$ openssl req -new -key ubuntu_server.key -out ubuntu_server.csr

Self-Sign Your Certificate

$ openssl x509 -req -days 365 -in ubuntu_server.csr -signkey ubuntu_server.key -out ubuntu_server.crt

Your self-signed certificate will be saved in the current working directory and you can confirm by running the ls command.

$ ls

Also, you can review the certificate details with the following command.

$ openssl x509 -text -noout -in ubuntu_server.crt
"
);

DROP TABLE IF EXISTS `schnipsel_types`;
CREATE TABLE `schnipsel_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO schnipsel_types VALUES("2","procedure"),
("6","Shell");

DROP TABLE IF EXISTS `schnipsel_comments`;
CREATE TABLE `schnipsel_comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code_id` int NOT NULL,
  `parent_id` int NOT NULL,
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO schnipsel_comments VALUES("5","43","0","Ravi Saive",
"in this guide, we described how to generate self-signed SSL certificates with the openssl tool in Linux. Do note that self-signed certificates are considered insecure by all major web browsers.");

DROP TABLE IF EXISTS `schnipsel_links`;
CREATE TABLE `schnipsel_links` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code_id` int NOT NULL,
  `link_text` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `link_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO schnipsel_links VALUES("7","39","Lazarus Forum","https://www.lazarusforum.de/viewtopic.php?p=135847&hilit=bookmarks#p135847"),
("8","42","From Stackoverflow","https://stackoverflow.com/questions/1091945/what-characters-do-i-need-to-escape-in-xml-documents/46637835#46637835"),
("9","43","How to Generate Self-Signed SSL Certificates using OpenSSL","https://www.ubuntumint.com/generate-self-signed-ssl-certificates-using-openssl/");

DROP TABLE IF EXISTS `schnipsel_required`;
CREATE TABLE `schnipsel_required` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code_id` int NOT NULL,
  `required_id` int NOT NULL,
  `required_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `required_hint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `required_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO schnipsel_required VALUES("33","38","39","PDF-Bookmark","Unit for PDF Outlines","");

DROP TABLE IF EXISTS `schnipsel_names`;
CREATE TABLE `schnipsel_names` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lang_id` int NOT NULL,
  `type_id` int NOT NULL,
  `Schnipsel_Name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO schnipsel_names VALUES("37","3","2","ODBC-Treiber"),
("40","3","2","Scroll Memo without Scrollbars (Send up / down Key)"),
("42","3","2","XML String Escapes"),
("43","20","6","How to Generate Self-Signed SSL Certificates");





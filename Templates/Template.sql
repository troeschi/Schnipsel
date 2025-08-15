SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `schnipsel`
--
CREATE DATABASE IF NOT EXISTS `schnipsel` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `schnipsel`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `schnipsel_bookmarks`
--

CREATE TABLE `schnipsel_bookmarks` (
  `id` int NOT NULL,
  `schnipsel_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `schnipsel_codes`
--

CREATE TABLE `schnipsel_codes` (`id` int NOT NULL,`schnipsel_id` int NOT NULL,`version` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,`author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,`schnipsel` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `schnipsel_codes`
--

INSERT INTO `schnipsel_codes` (`id`, `schnipsel_id`, `version`, `author`, `schnipsel`) VALUES (|VALUES:|); 

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `schnipsel_comments`
--

CREATE TABLE `schnipsel_comments` (
  `id` int NOT NULL,
  `code_id` int NOT NULL,
  `parent_id` int NOT NULL,
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `schnipsel_comments`
--

INSERT INTO [TABLE:`schnipsel_comments`] (`id`, `code_id`, `parent_id`, `author`, `comment`) VALUES (|VALUES:|);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `schnipsel_favorites`
--

CREATE TABLE `schnipsel_favorites` (
  `id` int NOT NULL,
  `schnipsel_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `schnipsel_favorites`
--

INSERT INTO [TABLE:`schnipsel_favorites`] (`id`, `schnipsel_id`) VALUES (|VALUES:|);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `schnipsel_language`
--

CREATE TABLE `schnipsel_language` (
  `id` int NOT NULL,
  `Language` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Lang_short` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `schnipsel_language`
--

INSERT INTO [TABLE:`schnipsel_language`] (`id`, `Language`, `Lang_short`) VALUES (|VALUES:|);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `schnipsel_links`
--

CREATE TABLE `schnipsel_links` (
  `id` int NOT NULL,
  `code_id` int NOT NULL,
  `link_text` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `link_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `schnipsel_links`
--

INSERT INTO [TABLE:`schnipsel_links`] (`id`, `code_id`, `link_text`, `link_url`) VALUES (|VALUES:|);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `schnipsel_names`
--

CREATE TABLE `schnipsel_names` (
  `id` int NOT NULL,
  `lang_id` int NOT NULL,
  `type_id` int NOT NULL,
  `Schnipsel_Name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `schnipsel_names`
--

INSERT INTO [TABLE:`schnipsel_names`] (`id`, `lang_id`, `type_id`, `Schnipsel_Name`) VALUES (|VALUES:|);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `schnipsel_required`
--

CREATE TABLE `schnipsel_required` (
  `id` int NOT NULL,
  `code_id` int NOT NULL,
  `required_id` int NOT NULL,
  `required_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `required_hint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `required_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `schnipsel_required`
--

INSERT INTO [TABLE:`schnipsel_required`] (`id`, `code_id`, `required_id`, `required_name`, `required_hint`, `required_link`) VALUES (|VALUES:|);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `schnipsel_types`
--

CREATE TABLE `schnipsel_types` (
  `id` int NOT NULL,
  `TypeName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `schnipsel_types`
--

INSERT INTO [TABLE:`schnipsel_types`] (`id`, `TypeName`) VALUES (|VALUES:|);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `schnipsel_bookmarks`
--
ALTER TABLE `schnipsel_bookmarks`
  ADD KEY `id` (`id`);

--
-- Indizes für die Tabelle `schnipsel_codes`
--
ALTER TABLE `schnipsel_codes`
  ADD KEY `id` (`id`);

--
-- Indizes für die Tabelle `schnipsel_comments`
--
ALTER TABLE `schnipsel_comments`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indizes für die Tabelle `schnipsel_favorites`
--
ALTER TABLE `schnipsel_favorites`
  ADD KEY `id` (`id`);

--
-- Indizes für die Tabelle `schnipsel_language`
--
ALTER TABLE `schnipsel_language`
  ADD KEY `id` (`id`);

--
-- Indizes für die Tabelle `schnipsel_links`
--
ALTER TABLE `schnipsel_links`
  ADD KEY `id` (`id`);

--
-- Indizes für die Tabelle `schnipsel_names`
--
ALTER TABLE `schnipsel_names`
  ADD KEY `id` (`id`);

--
-- Indizes für die Tabelle `schnipsel_required`
--
ALTER TABLE `schnipsel_required`
  ADD KEY `id` (`id`);

--
-- Indizes für die Tabelle `schnipsel_types`
--
ALTER TABLE `schnipsel_types`
  ADD UNIQUE KEY `id` (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `schnipsel_bookmarks`
--
ALTER TABLE `schnipsel_bookmarks`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `schnipsel_codes`
--
ALTER TABLE `schnipsel_codes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT für Tabelle `schnipsel_comments`
--
ALTER TABLE `schnipsel_comments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `schnipsel_favorites`
--
ALTER TABLE `schnipsel_favorites`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `schnipsel_language`
--
ALTER TABLE `schnipsel_language`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT für Tabelle `schnipsel_links`
--
ALTER TABLE `schnipsel_links`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `schnipsel_names`
--
ALTER TABLE `schnipsel_names`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT für Tabelle `schnipsel_required`
--
ALTER TABLE `schnipsel_required`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT für Tabelle `schnipsel_types`
--
ALTER TABLE `schnipsel_types`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
--
COMMIT;



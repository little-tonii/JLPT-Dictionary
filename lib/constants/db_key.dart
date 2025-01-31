abstract class JlptDictionaryDatabase {
  static const String databaseName = 'jlpt_dictionary.db';
  static const int databaseVersion = 1;

  static const String createKanjiTableQuery = """
    CREATE TABLE ${KanjiKeys.tableName}(
      ${KanjiKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${KanjiKeys.viet} TEXT,
      ${KanjiKeys.kanji} TEXT,
      ${KanjiKeys.jlptLevel} TEXT,
      ${KanjiKeys.numberOfWritingStrokes} INTEGER,
      ${KanjiKeys.kunyomi} TEXT,
      ${KanjiKeys.onyomi} TEXT
    );
  """;

  static const String createKanjiSampleTableQuery = """
    CREATE TABLE ${KanjiSampleKeys.tableName}(
      ${KanjiSampleKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${KanjiSampleKeys.kanjiId} INTEGER,
      ${KanjiSampleKeys.kanjiForm} TEXT,
      ${KanjiSampleKeys.normalForm} TEXT,
      ${KanjiSampleKeys.meaning} TEXT,
      ${KanjiSampleKeys.yomiType} TEXT,
      FOREIGN KEY(${KanjiSampleKeys.kanjiId}) REFERENCES ${KanjiKeys.tableName}(${KanjiKeys.id}),
    );
  """;

  static const String createVocabularyTableQuery = """
    CREATE TABLE ${VocabularyKeys.tableName}(
      ${VocabularyKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${VocabularyKeys.kanjiForm} TEXT,
      ${VocabularyKeys.normalForm} TEXT,
      ${VocabularyKeys.meaning} TEXT,
      ${VocabularyKeys.jlptLevel} TEXT
    );
  """;
}

abstract class VocabularyKeys {
  static const String tableName = 'vocabularies';
  static const String id = 'id';
  static const String kanjiForm = 'kanji_form';
  static const String normalForm = 'normal_form';
  static const String meaning = 'meaning';
  static const String jlptLevel = 'jlpt_level';
}

abstract class KanjiSampleKeys {
  static const String tableName = 'kanji_samples';
  static const String id = 'id';
  static const String kanjiId = 'kanji_id';
  static const String kanjiForm = 'kanji_form';
  static const String normalForm = 'normal_form';
  static const String meaning = 'meaning';
  static const String yomiType = 'yomi_type';
}

abstract class KanjiKeys {
  static const String tableName = 'kanjis';
  static const String id = 'id';
  static const String viet = 'viet';
  static const String kanji = 'kanji';
  static const String jlptLevel = 'jlpt_level';
  static const String numberOfWritingStrokes = 'number_of_writing_strokes';
  static const String kunyomi = "kunyomi";
  static const String onyomi = "onyomi";

  static const String sounds = "sounds";
  static const String samples = "samples";
}

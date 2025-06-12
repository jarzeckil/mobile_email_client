import 'dart:io';

// ignore: unused_import
import 'package:mobile_email_client/app_imports.dart';
import 'package:mobile_email_client/service/models/mail_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper extends ChangeNotifier {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._();
    return _databaseHelper!;
  }

  String mailTable = 'mail_table';
  String colUid = 'uid';
  String colDate = 'date';
  String colSender = 'sender';
  String colSubject = 'subject';
  String colPlainText = 'plainText';

  static Database? _database;

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String path = dir.path + 'mail.db';

    final mailDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );

    print("Initializing database at: $path");

    return mailDatabase;
  }

  void _createDatabase(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $mailTable ('
      '$colUid INTEGER,'
      '$colDate TEXT,'
      '$colSender TEXT,'
      '$colSubject TEXT,'
      '$colPlainText TEXT'
      ')',
    );
  }

  Future<void> deleteDatabaseFile() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String path = dir.path + 'mail.db';

    final file = File(path);
    if (await file.exists()) {
      await file.delete();
      print('Baza danych usunięta.');
    } else {
      print('Baza danych nie istnieje.');
    }
  }

  Future<void> clearDatabase() async {
    await _database!.execute(
      'DELETE FROM $mailTable',
    );
    print('database cleared');
    loadMails();

  }

  Future<int> getEntityCount() async {
    final db = await database;
    final String query = "SELECT COUNT(*) AS mailCount FROM $mailTable";

    final queryResult = await db.rawQuery(query);

    final result = queryResult.first['mailCount'];

    return result as int;
  }

  Future<int> getMaxUid() async {
    final db = await database;
    final String query = "SELECT MAX($colUid) AS maxUid FROM $mailTable";

    final queryResult = await db.rawQuery(query);

    final result = queryResult.first['maxUid'];

    return result as int;
  }

  Future<int> getMinUid() async {
    final db = await database;
    final String query = "SELECT MIN($colUid) AS minUid FROM $mailTable";

    final queryResult = await db.rawQuery(query);

    final result = queryResult.first['minUid'];

    return result as int;
  }

  Future<List<Map<String, dynamic>>> getMailMapList(int n) async {
    final Database db = await database;

    String query = "SELECT * FROM $mailTable ORDER BY $colDate DESC";

    if (n != -1) {
      query += "LIMIT $n";
    }

    final result = await db.rawQuery(query);
    return result;
  }

  Future<void> insertMail(MimeMessage message) async {
    final Database db = await database;
    final mail = MailModel(message);
    final uid = message.uid;
    print("Inserting: $uid");

    String existingQuery = "SELECT * FROM $mailTable WHERE uid = $uid LIMIT 1";
    final existing = await db.rawQuery(existingQuery);

    if(existing.isEmpty) {
      await db.insert(mailTable, mail.toMap());
      loadMails();
    }
    else{
      print("Object $uid exists. Skipping.");
    }

  }

  List<MailModel> _mails = [];

  List<MailModel> get mails => _mails;

  Future<void> loadMails() async {
    print("loading");
    final data = await getMailMapList(-1);
    _mails =
        data.map((e) => MailModel.fromMapObject(e)).toList();
    notifyListeners();
  }
}

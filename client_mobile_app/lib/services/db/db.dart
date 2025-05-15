import 'package:my_security/models/Attachment.dart';
import 'package:my_security/models/report.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    final path = join(databasePath, 'mySafety.db');

    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  // When the database is first created, create a table to store breeds
  // and a table to store dogs.
  Future<void> _onCreate(Database db, int version) async {
    // Run the CREATE {breeds} TABLE statement on the database.
    await db.execute(
      'CREATE TABLE Reports(id TEXT PRIMARY KEY,idReal TEXT,dir INTEGER,office TEXT,text TEXT, subject TEXT, type TEXT,time TEXT,isAttachments INTEGER)',
    );
     await db.execute(
      'CREATE TABLE Attachments(id TEXT PRIMARY KEY,idReport TEXT,path TEXT,nameFile TEXT,ext TEXT)',
    );
  }

  // Define a function that inserts breeds into the database
  Future<void> insertReoprt(Reportx report) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Insert the Breed into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same breed is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'Reports',
      report.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the breeds from the breeds table.
  Future<List<Reportx>> Reports() async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Query the table for all the Breeds.
    final List<Map<String, dynamic>> maps =
        await db.query('Reports', orderBy: 'time DESC');

    // Convert the List<Map<String, dynamic> into a List<Breed>.
    return List.generate(maps.length, (index) => Reportx.fromMap(maps[index]));
  }

  Future<Reportx> report(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('Reports', where: 'id = ?', whereArgs: [id]);
    return Reportx.fromMap(maps[0]);
  }

  // A method that updates a breed data from the breeds table.
  Future<void> updateReport(Reportx report) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Update the given breed
    await db.update(
      'Reports',
      report.toMap(),
      // Ensure that the Breed has a matching id.
      where: 'id = ?',
      // Pass the Breed's id as a whereArg to prevent SQL injection.
      whereArgs: [report.id],
    );
  }

  // A method that deletes a breed data from the breeds table.
  Future<void> deleteReport(int id) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Remove the Breed from the database.
    await db.delete(
      'Reports',
      // Use a `where` clause to delete a specific breed.
      where: 'id = ?',
      // Pass the Breed's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
    

////////////////////////////////////Attachments/////////////////////////////////////

  Future<void> insertAttachment(Attachment attachment) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    await db.insert(
      'Attachments',
      attachment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateAttachment(Attachment attachment) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Update the given breed
    await db.update(
      'Attachments',
      attachment.toMap(),
      // Ensure that the Breed has a matching id.
      where: 'id = ?',
      // Pass the Breed's id as a whereArg to prevent SQL injection.
      whereArgs: [attachment.id],
    );
  }

  Future<List<Attachment>> attachment(String id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM Attachments WHERE idReport = "$id"');
    return List.generate(
        maps.length, (index) => Attachment.fromMap(maps[index]));
  }

}

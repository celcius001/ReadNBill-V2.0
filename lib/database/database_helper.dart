import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('readnbill.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE routes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        route_no TEXT NOT NULL,
        seq_from INTEGER NOT NULL,
        seq_to INTEGER NOT NULL
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getRoutes() async {
    final db = await database;

    return await db.query('routes', orderBy: 'route_no ASC');
  }

  Future<void> saveRoute(String routeNo, int seqFrom, int seqTo) async {
    final db = await database;

    final existing = await db.query(
      'routes',
      where: 'route_no = ?',
      whereArgs: [routeNo],
    );

    if (existing.isEmpty) {
      await db.insert('routes', {
        'route_no': routeNo,
        'seq_from': seqFrom,
        'seq_to': seqTo,
      });
    } else {
      await db.update(
        'routes',
        {'seq_from': seqFrom, 'seq_to': seqTo},
        where: 'route_no = ?',
        whereArgs: [routeNo],
      );
    }
  }

  Future<int> deleteRoute(String routeNo) async {
    final db = await database;

    return await db.delete(
      'routes',
      where: 'route_no = ?',
      whereArgs: [routeNo],
    );
  }
}

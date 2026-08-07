import 'package:path/path.dart';
import 'package:readnbill/models/rate_model.dart';
import 'package:readnbill/models/route_model.dart';
import 'package:readnbill/models/tempreading_model.dart';
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
        RouteCode TEXT NOT NULL,
        TownCode TEXT NOT NULL,
        Description TEXT NOT NULL,
        ServiceDayFrom INTEGER NOT NULL,
        ServiceDayTo INTEGER NOT NULL,
        DueDay INTEGER NOT NULL,
        SequenceFrom INTEGER NOT NULL,
        SequenceTo INTEGER NOT NULL
      )
    ''');

    // TempReadings table
    await db.execute('''
      CREATE TABLE temp_readings(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ServicePeriodEnd TEXT,
        AccountNumber TEXT UNIQUE,
        Route TEXT,
        SequenceNumber INTEGER,
        ConsumerName TEXT,
        ConsumerAddress TEXT,
        MeterNumber TEXT,
        PreviousReading2 REAL,
        PreviousReading1 REAL,
        PreviousReading REAL,
        ReadingDate TEXT,
        ReadBy TEXT,
        PowerReadings REAL,
        DemandReadings REAL,
        FieldFindings TEXT,
        MissCodes TEXT,
        Remarks TEXT,
        UpdateStatus TEXT,
        ConsumerType TEXT,
        AccountStatus TEXT,
        ShortAccountNumber TEXT,
        Multiplier REAL,
        MeterDigits INTEGER,
        Coreloss REAL,
        CorelossKWHLimit REAL,
        AdditionalKWH REAL,
        TSFRental REAL,
        SchoolTag TEXT,
        SDiscountStatus TEXT,
        ConnectionDate TEXT,
        QCAmount REAL,
        KWHConsumption REAL,
        PCAmount REAL,
        EPAmount REAL,
        ArrAmount REAL,
        BCAmount REAL
      )
    ''');

    // Rates table
    await db.execute('''
      CREATE TABLE rates (
        ConsumerType TEXT NOT NULL,
        ServicePeriodEnd TEXT NOT NULL,
        LifelineLevel REAL,

        GenSysCharge REAL NOT NULL,
        FBHCCharge REAL,
        FPCAAdjCharge REAL,
        ICERA REAL,
        OGACharge REAL,
        OGACurrCharge REAL,
        SysLossCharge REAL NOT NULL,
        OSLACharge REAL,
        OSLACurrCharge REAL,
        TransDemCharge REAL,
        OTCADemCharge REAL,
        OTCADemCurrCharge REAL,
        TransSysCharge REAL NOT NULL,
        OTCASysCharge REAL NOT NULL,
        OTCASysCurrCharge REAL,
        DistribDemCharge REAL,
        DistribSysCharge REAL NOT NULL,
        SupplyRetCusCharge REAL NOT NULL,
        SupplySysCharge REAL,
        MetRetCusCharge REAL NOT NULL,
        MetSysCharge REAL,
        PAR REAL,
        LoanCondonation REAL NOT NULL,
        LifeLineRateSubsidy REAL NOT NULL,
        OLRACharge REAL,
        OLRACurrCharge REAL,
        SeniorCitizenSubsidy REAL NOT NULL,
        OSrRACharge REAL,
        ICCSCharge REAL,
        VATGen REAL NOT NULL,
        VATTrans REAL NOT NULL,
        VATSL REAL NOT NULL,
        VATDist REAL NOT NULL,
        VATOthers REAL NOT NULL,
        UCMissElecCharge REAL NOT NULL,
        MEREDCICharge REAL NOT NULL,
        UCEnvCharge REAL NOT NULL,
        StrandedCost REAL,
        NPCSDCharge REAL NOT NULL,
        FITAllCharge REAL NOT NULL,
        DefAcctgAdj REAL,
        PPACharge REAL,
        OGA3Charge REAL,
        OTCASys3Charge REAL,
        OTCADem3Charge REAL,
        OSLA3Charge REAL,
        OLRA3Charge REAL,
        RealPropertyTax REAL,
        FranchiseTax REAL,

        PRIMARY KEY (ConsumerType, ServicePeriodEnd)
      )
    ''');
  }

  Future<List<RouteModel>> getRoutes() async {
    final db = await database;

    final result = await db.query('routes');

    return result.map<RouteModel>((row) => RouteModel.fromMap(row)).toList();
  }

  Future<List<TempModel>> getReadingsByRoute(String routeCode) async {
    final db = await database;

    final result = await db.query(
      'temp_readings',
      where: 'Route = ?',
      whereArgs: [routeCode],
      orderBy: 'SequenceNumber ASC',
    );

    return result.map<TempModel>((row) => TempModel.fromMap(row)).toList();
  }

  Future<RateModel?> getRate(String consumerType) async {
    final db = await database;

    final result = await db.query(
      'rates',
      where: 'ConsumerType = ?',
      whereArgs: [consumerType],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return RateModel.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<void> saveRoute(
    String routeCode,
    String townCode,
    String desc,
    int dayFrom,
    int dayTo,
    int dueDay,
    int seqFrom,
    int seqTo,
  ) async {
    final db = await database;

    final existing = await db.query(
      'routes',
      where: 'RouteCode = ?',
      whereArgs: [routeCode],
    );

    if (existing.isEmpty) {
      await db.insert('routes', {
        'RouteCode': routeCode,
        'TownCode': townCode,
        'Description': desc,
        'ServiceDayFrom': dayFrom,
        'ServiceDayTo': dayTo,
        'DueDay': dueDay,
        'SequenceFrom': seqFrom,
        'SequenceTo': seqTo,
      });
    } else {
      await db.update(
        'routes',
        {'SequenceFrom': seqFrom, 'SequenceTo': seqTo},
        where: 'RouteCode = ?',
        whereArgs: [routeCode],
      );
    }
  }

  Future<void> saveTempReadings(List<TempModel> readings) async {
    final db = await database;

    final batch = db.batch();

    for (final reading in readings) {
      batch.insert(
        'temp_readings',
        reading.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<void> saveRates(List<RateModel> rates) async {
    final db = await database;

    final batch = db.batch();

    for (final rate in rates) {
      batch.insert(
        'rates',
        rate.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<int> updateReading({
    required String accountNumber,
    required Map<String, dynamic> values,
  }) async {
    final db = await database;

    return db.update(
      'temp_readings',
      values,
      where: 'AccountNumber = ?',
      whereArgs: [accountNumber],
    );
  }

  Future<void> deleteRoute(String routeCode) async {
    final db = await database;

    await db.transaction((txn) async {
      // Delete associated temp readings first
      await txn.delete(
        'temp_readings',
        where: 'Route = ?',
        whereArgs: [routeCode],
      );

      // Then delete the route
      await txn.delete(
        'routes',
        where: 'RouteCode = ?',
        whereArgs: [routeCode],
      );
    });
  }

  Future<void> deleteRatesIfNoRoutes() async {
    final db = await database;

    final routeCount = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM routes'),
    );

    if (routeCount == 0) {
      await db.delete('rates');
    }
  }
}

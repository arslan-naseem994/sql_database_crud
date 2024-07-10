import 'dart:io' as io;

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDatabase();
    return _db;
  }

// Inside your DBHelper class
  initDatabase() async {
    io.Directory documentDirectory = await getApplicationCacheDirectory();
    String path = join(documentDirectory.path, 'mydatabases.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute('CREATE TABLE student (studentName TEXT, studentAge TEXT)');
  }

  Future<void> insert(
    String studentName,
    String age,
  ) async {
    var dbClient = await db;
    await dbClient!.insert(
      'student',
      {
        'studentName': studentName.toString(),
        'studentAge': age.toString(),
      },
    );
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final dbClient = await db;
    return dbClient!.query('student');
  }

  Future<int> delete(String age) async {
    var dbClient = await db;
    return await dbClient!
        .delete('student', where: 'studentAge = ?', whereArgs: [age]);
  }

  Future<int> updateData(String oldData, String newData) async {
    var dbClient = await db;
    return await dbClient!.update(
      'student',
      {'studentName': newData},
      where: 'studentName = ?',
      whereArgs: [oldData],
    );
  }
}





// _onCreate(Database db, int version) async {
//     await db.execute(
//         'CREATE TABLE cart (id INTEGER PRIMARY KEY , productId VARCHAR UNIQUE,productName TEXT,initialPrice INTEGER, productPrice INTEGER , quantity INTEGER, unitTag TEXT , image TEXT )');
//   }


//  Future<int> updateQuantity(Cart cart) async {
//     var dbClient = await db;
//     return await dbClient!
//         .update('cart', cart.toMap(), where: 'id = ?', whereArgs: [cart.id]);
//   }
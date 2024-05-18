import 'dart:io';


import 'package:fluttertask/src/domain/models/product_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'cart_table';

  static const id = 'id';
  static const title = 'title';
  static const category = 'category';
  static const description = 'description';
  static const image = 'image';
  static const price = 'price';


  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }


  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }


  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $id INTEGER PRIMARY KEY,
            $title TEXT NOT NULL,
            $description TEXT NOT NULL,
            $category TEXT NOT NULL,
            $image TEXT NOT NULL,
            $price TEXT NOT NULL
          )
          ''');
  }



  // Insert a row
  Future<int> insertProduct(ProductModel product) async {
    Database db = await instance.database;
    return await db.insert(table, product.toMap());
  }

  //Delete a row
  Future<int> delete(int idTemp) async {
    print("DeletedID : ${idTemp.toString()}");
    Database db = await instance.database;
    return await db.delete(table, where: '$id = ?', whereArgs: [idTemp]);
  }

  //get row count
  Future<int> getProductCount() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.rawQuery('SELECT COUNT(*) FROM $table');
    int count = Sqflite.firstIntValue(result)!;
    return count;
  }


  Future<List<ProductModel>> getAllProducts() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return ProductModel(
        id: maps[i][id],
        title: maps[i][title],
        price: maps[i][price],
        description:  maps[i][description],
        category:  maps[i][category],
        image:  maps[i][image]

      );
    });
  }
  Future<String> getTotalPriceFromDatabase() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result =
    await db.rawQuery('SELECT SUM(price) AS total FROM cart_table');

    return result.first['total']??"0.0";
  }
}
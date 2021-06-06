import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:shopping/models/shopping_list.dart';
import 'package:shopping/models/list_items.dart';

class DbHelper{
  final int version = 1;
  Database db;

  //Factory constructor
  static final DbHelper _dbHelper = DbHelper._internal();
  DbHelper._internal();
  factory DbHelper(){
    return _dbHelper;
  }

  Future<Database> openDb() async{
    if (db == null) {
      db = await openDatabase(
          join(
              await getDatabasesPath(),
              'shopping.db'
          ),
          onCreate: (database, version){
            database.execute('CREATE TABLE lists (id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)');
            database.execute(
                'CREATE TABLE items (id INTEGER PRIMARY KEY, idList INTEGER, name TEXT, quantity TEXT, note TEXT, ' +
                    'FOREIGN KEY (idList) REFERENCES lists(id))');
            },
          version: version
      );
    }
    return db;
  }

  Future<int> insertList(ShoppingList list) async{
    int id = await this.db.insert(
      'lists',
      list.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<int> insertItem(ListItem item) async{
    int id = await this.db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<ShoppingList>> getLists() async{
    final List<Map<String, dynamic>> maps = await db.query("lists");
    return List.generate(maps.length, (i){
      return ShoppingList(
          maps[i]['id'],
          maps[i]['name'],
          maps[i]['priority'],
      );
    });
  }

  Future<List<ListItem>> getItems(int idList) async{
    final List<Map<String, dynamic>> maps = await db.query(
      'items',
      where: 'idList = ?',
      whereArgs: [idList],
    );
    return List.generate(maps.length, (i){
      return ListItem(
          maps[i]['id'],
          maps[i]['idList'],
          maps[i]['name'],
          maps[i]['quantity'],
          maps[i]['note']
      );
    });
  }

  Future<int> deleteList(ShoppingList list) async{
    int result = await db.delete(
      "items",
      where: "idList = ?",
      whereArgs: [list.id],
    );
    return result;
  }

  Future tesdDb() async{
    db = await openDb();
    await db.execute('INSERT INTO lists VALUES (5, "Fruit", 2)');
    await db.execute('INSERT INTO items VALUES (5, 0, "Apples", "2 KG", "Better if they are green")');
    List lists = await db.rawQuery('select * from lists');
    List items = await db.rawQuery('select * from items');
    print(lists.toString());
    print(items.toString());
  }
}
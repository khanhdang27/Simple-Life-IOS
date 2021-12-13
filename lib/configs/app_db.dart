import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDb {
  static final String name = 'baseproject.db';
  static final String tbUser = 'user';
  static final String tbCart = 'cart';
  static final String tbFavorite = 'favorite';
  static late Database db;

  Future<Database> setupDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, name);
    db = await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );
    return db;
  }

  Future<void> clearDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, name);
    await db.close();
    await deleteDatabase(path);
    await setupDatabase();
  }

  Future<void> onCreate(Database database, int version) async {
    await database.execute(
      "CREATE TABLE $tbUser "
      "("
      "user_id INTEGER PRIMARY KEY, "
      "token TEXT, "
      "is_login INT"
      ")",
    );
    await database.execute(
      "CREATE TABLE $tbCart "
      "("
      "product_id INT, "
      "quantity INT"
      ")",
    );
    await database.execute(
      "CREATE TABLE $tbFavorite "
      "("
      "product_id INT"
      ")",
    );
  }

  Future<void> onUpgrade(
    Database database,
    int oldVersion,
    int newVersion,
  ) async {}

  static final AppDb _instance = AppDb._internal();

  factory AppDb() {
    return _instance;
  }

  AppDb._internal();
}

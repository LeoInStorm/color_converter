import 'package:color_converter/data/task_color_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase()  async{
  final String path = join(await getDatabasesPath(),'task.db');
  return openDatabase(path, onCreate:(db, version) {
    db.execute(TaskColorDao.tableSql);
  },version: 1,);
}

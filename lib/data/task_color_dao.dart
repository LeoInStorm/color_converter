import 'package:color_converter/components/task_color.dart';
import 'package:color_converter/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskColorDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_hexValue TEXT,'
      '$_rgbValue TEXT,'
      '$_hsvValue TEXT,'
      '$_hslValue TEXT)';

  static const String _tablename = 'colorTable';
  static const String _hexValue = 'hexColor';
  static const String _rgbValue = 'rgbColor';
  static const String _hsvValue = 'hsvColor';
  static const String _hslValue = 'hslColor';

  save(TaskColor tarefa) async {
    print("Acessando o banco de dados...");
    final Database bancoDeDados = await getDatabase();
    var itemExist = await find(tarefa.hexValue);
    Map<String, dynamic> taskMap = toMap(tarefa);
    if (itemExist.isEmpty) {
      print('a tarefa nao existia');
      return await bancoDeDados.insert(_tablename, taskMap);
    } else {
      print("a tarefa já existe");
      return bancoDeDados.update(_tablename, taskMap,
          where: '$_hexValue = ?', whereArgs: [tarefa.hexValue]);
    }
  }

  Map<String, dynamic> toMap(TaskColor tarefa) {
    print("convertendo em map");
    final Map<String, dynamic> mapaDeCores = {};
    mapaDeCores[_hexValue] = tarefa.hexValue;
    mapaDeCores[_rgbValue] = tarefa.rgbValue;
    mapaDeCores[_hsvValue] = tarefa.hsvValue;
    mapaDeCores[_hslValue] = tarefa.hslValue;

    return mapaDeCores;
  }

  Future<List<TaskColor>> findALL() async {
    print("Acessando o banco de dados...");
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print("Procurando no db... encontrado: $result");
    return toList(result);
  }

  List<TaskColor> toList(List<Map<String, dynamic>> mapaDeCores) {
    print("convertendo to list:");
    final List<TaskColor> tarefas = [];

    for (Map<String, dynamic> linha in mapaDeCores) {
      final TaskColor tarefa = TaskColor(
          hexValue: linha[_hexValue],
          rgbValue: linha[_rgbValue],
          hsvValue: linha[_hsvValue],
          hslValue: linha[_hslValue],);
      tarefas.add(tarefa);
    }
    return tarefas;
  }

  Future<List<TaskColor>> find(String nomeDaTarefa) async {
    print('Acessando banco de dados');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados
        .query(_tablename, where: '$_hexValue = ?', whereArgs: [nomeDaTarefa]);
    print("tarefa encontrada ${toList(result)}");
    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    print('Deletando a tarefa: $nomeDaTarefa');
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(_tablename, where: '$_hexValue = ?', whereArgs: [nomeDaTarefa]);
  }
}

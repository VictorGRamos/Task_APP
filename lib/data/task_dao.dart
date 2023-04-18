import 'package:nosso_primeiro_projeto/components/task.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart';

class TaskDao {

  static const String tableSql = 'CREATE TABLE $_tablename($_name TEXT, $_difficulty INTEGER, $_image TEXT, $_level INTEGER)';

  static const String _tablename = 'TaskTable2';
  static const String _name = 'nome';
  static const String _difficulty = 'dificuldade';
  static const String _image = 'image';
  static const String _level = 'level';
 

  save(Task tarefa) async{

    final Database bancodeDados = await getDatabase();
    var itemExists = await find(tarefa.nome);
    Map<String, dynamic> taskMap = toMap(tarefa);


    //Valida se tarefa já existe
    if (itemExists.isEmpty) {

      return await bancodeDados.insert(
        _tablename, taskMap);
      
    }else{
      return await bancodeDados.update(
        _tablename, taskMap, where: '$_name = ?', whereArgs: [tarefa.nome]);
    }


  }

  Future<List<Task>> findAll() async{

    final Database bancodeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancodeDados.query(_tablename);
    return toList(result);

  }

  Future<List<Task>> find(String nomedaTarefa) async{

    final Database bancodeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancodeDados.query(
      _tablename, where: '$_name = ?', whereArgs: [nomedaTarefa]);
    return toList(result);
    
  }

  delete(String nomedaTarefa) async{

    final Database bancodeDados = await getDatabase();
    return bancodeDados.delete(
      _tablename, where: '$_name = ?', whereArgs: [nomedaTarefa]);

  }

  List<Task> toList(List<Map<String, dynamic>> listaDeTarefas){

    final List<Task> tarefas = [];

    for (Map<String, dynamic> linha in listaDeTarefas){
      final Task tarefa = Task(linha[_name], linha[_image], linha[_difficulty], linha[_level]);
      tarefas.add(tarefa);
    }

    return tarefas;

  }

  Map<String, dynamic> toMap(Task tarefa){

    final Map<String, dynamic> mapadeTarefas = {};
    mapadeTarefas[_name] = tarefa.nome;
    mapadeTarefas[_difficulty] = tarefa.dificuldade;
    mapadeTarefas[_image] = tarefa.foto;
    mapadeTarefas[_level] = tarefa.nivel;
    return mapadeTarefas;

  }

}

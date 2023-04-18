import 'package:flutter/material.dart';
import '../data/task_dao.dart';

abrirDialog(BuildContext context, String nomedaTarefa) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deletar?'),
          content: const Text('Deseja deletar essa tarefa?'),
          actions: [
            MaterialButton(
                onPressed: () {
                  TaskDao().delete(nomedaTarefa);
                  Navigator.pop(context);
                },
                child: const Text("Sim")),
            MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Não'))
          ],
        );
      });
}

import 'dart:io';
import 'package:args/command_runner.dart';
import '../../../repositories/students_repository.dart';

class DeleteCommand extends Command {
  final StudentsDioRepository repository;

  @override
  String get description => 'Delete Student';

  @override
  String get name => 'delete';

  DeleteCommand(this.repository) {
    argParser.addOption('id', abbr: 'i', help: 'Student id');
  }

  @override
  Future<void> run() async {
    final id = int.parse(argResults?['id']);

    if (argResults?['id'] == null) {
      print('Por favor, insira o id do aluno utilizando --id=0 ou -i 0');
      return;
    }

    final students = await repository.findById(id);
    print('Deseja Deletar o aluno ${students.name} ??');

    final confirmDelete = stdin.readLineSync();
    if (confirmDelete?.toLowerCase() == 's') {
      await repository.deleteById(id);
      print('Aluno deletado com sucesso!');
    } else {
      print('Operação cancelada');
    }
  }
}

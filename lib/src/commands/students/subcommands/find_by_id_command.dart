import 'package:args/command_runner.dart';
import '../../../repositories/students_repository.dart';

class FindByIdCommand extends Command {
  final StudentsDioRepository studentsRepository;

  @override
  String get description => 'Find Students By Id';

  @override
  String get name => 'byId';

  FindByIdCommand(this.studentsRepository) {
    argParser.addOption('id', abbr: 'i', help: 'Students id');
  }

  @override
  Future<void> run() async {
    if (argResults?['id'] == null) {
      print('Por favor, insira o id do aluno utilizando --id=0 ou -i 0');
      return;
    }

    final id = int.parse(argResults?['id']);

    print('Aguarde, buscando dados...');
    final students = await studentsRepository.findById(id);
    print('===========================================');
    print('ID: ${students.id}');
    print('Name: ${students.name}');
    print('Age: ${students.age ?? 'não informado'}');
    print('Address - ${students.address.street} - ${students.address.zipCode}');
    print('Courses');
    students.nameCourses.forEach(print);
  }
}

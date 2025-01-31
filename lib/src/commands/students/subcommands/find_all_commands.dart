import 'dart:io';
import 'package:args/command_runner.dart';
import '../../../repositories/students_repository.dart';

class FindAllCommands extends Command {
  final StudentsDioRepository studentsRepository;

  @override
  String get description => 'Find All Students';

  @override
  String get name => 'findAll';

  FindAllCommands(this.studentsRepository);

  @override
  Future<void> run() async {
    print('Aguarde...');
    final students = await studentsRepository.findAll();
    print('Deseja mostrar os cursos (S ou N)?');
    final showCourses = stdin.readLineSync();
    for (var student in students) {
      if (showCourses?.toLowerCase() == 's') {
        print(
            '${student.id} - ${student.name} - ${student.courses.where((course) => course.isStudent).map((e) => e.name).toList()}');
      } else {
        print('${student.id} - ${student.name}');
      }
    }
  }
}

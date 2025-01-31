import 'dart:io';
import 'package:args/command_runner.dart';
import '../../../models/address.dart';
import '../../../models/city.dart';
import '../../../models/phone.dart';
import '../../../models/students.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/students_repository.dart';

class InsertCommand extends Command {
  final StudentsDioRepository studentsRepository;
  final productRepository = ProductDioRepository();

  @override
  String get description => 'Insert Student';

  @override
  String get name => 'insert';

  InsertCommand(this.studentsRepository) {
    argParser.addOption('file', abbr: 'f', help: 'Path of file the csv');
  }

  @override
  Future<void> run() async {
    final filePath = argResults?['file'];

    print('Aguarde...');
    final students = File(filePath).readAsLinesSync();
    print('==================================================');

    for (var student in students) {
      final studentsData = student.split(';');
      final coursesCsv =
          studentsData[2].split(',').map((t) => t.trim()).toList();

      final coursesFuture = coursesCsv.map((c) async {
        final course = await productRepository.findByName(c);
        course.isStudent = true;
        return course;
      }).toList();

      final courses = await Future.wait(coursesFuture);

      final studentsModel = Students(
        name: studentsData[0],
        age: int.parse(studentsData[1]),
        nameCourses: coursesCsv,
        courses: courses,
        address: Address(
          street: studentsData[3],
          number: int.parse(studentsData[4]),
          zipCode: studentsData[5],
          city: City(id: 1, name: studentsData[6]),
          phone: Phone(ddd: int.parse(studentsData[7]), phone: studentsData[8]),
        ),
      );

      await studentsRepository.insert(studentsModel);
    }
    print('Aluno adicionado com sucesso!!!');
  }
}

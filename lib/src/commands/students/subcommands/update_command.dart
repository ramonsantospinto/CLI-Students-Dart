import 'dart:io';
import 'package:args/command_runner.dart';
import '../../../models/address.dart';
import '../../../models/city.dart';
import '../../../models/phone.dart';
import '../../../models/students.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/students_repository.dart';

class UpdateCommand extends Command {
  final StudentsDioRepository studentsRepository;
  final productRepository = ProductDioRepository();

  @override
  String get description => 'Update Student';

  @override
  String get name => 'update';

  UpdateCommand(this.studentsRepository) {
    argParser.addOption('file', abbr: 'f', help: 'Path of file the csv');
    argParser.addOption('id', abbr: 'i', help: 'Student id');
  }

  @override
  Future<void> run() async {
    final filePath = argResults?['file'];
    final id = argResults?['id'];

    if (id == null) {
      print('Por favor, insira o id do aluno utilizando --i=0 ou -i 0');
      return;
    }

    final students = File(filePath).readAsLinesSync();

    if (students.length > 1) {
      print('Por favor, insira apenas um aluno no arquivo $filePath');
      return;
    } else if (students.isEmpty) {
      print('Por favor insira um aluno no arquivo $filePath');
      return;
    }

    final student = students.first;

    final studentstData = student.split(';');
    final coursesCsv =
        studentstData[2].split(',').map((t) => t.trim()).toList();

    final coursesFuture = coursesCsv.map((c) async {
      final course = await productRepository.findByName(c);
      course.isStudent = true;
      return course;
    }).toList();

    final courses = await Future.wait(coursesFuture);

    final studentsModel = Students(
      id: int.parse(id),
      name: studentstData[0],
      age: int.parse(studentstData[1]),
      nameCourses: coursesCsv,
      courses: courses,
      address: Address(
        street: studentstData[3],
        number: int.parse(studentstData[4]),
        zipCode: studentstData[5],
        city: City(id: 1, name: studentstData[6]),
        phone: Phone(ddd: int.parse(studentstData[7]), phone: studentstData[8]),
      ),
    );

    await studentsRepository.update(studentsModel);

    print('Aluno atualizado com sucesso!!!');
  }
}

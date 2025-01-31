import 'package:dio/dio.dart';
import '../models/students.dart';

class StudentsDioRepository {
  Future<List<Students>> findAll() async {
    try {
      final resultStudents = await Dio().get('http://localhost:8080/students');

      return resultStudents.data
          .map<Students>((students) => Students.fromMap(students))
          .toList();
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<Students> findById(int id) async {
    try {
      final resultStudents =
          await Dio().get('http://localhost:8080/students/$id');

      if (resultStudents.data == null) {
        throw Exception();
      }

      return Students.fromMap(resultStudents.data);
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> insert(Students student) async {
    try {
      await Dio().post(
        'http://localhost:8080/students',
        data: student.toMap(),
      );
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> update(Students student) async {
    try {
      await Dio().put(
        'http://localhost:8080/students/${student.id}',
        data: student.toMap(),
      );
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> deleteById(int id) async {
    try {
      await Dio().delete('http://localhost:8080/students/$id');
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }
}

import 'package:dio/dio.dart';
import '../models/courses.dart';

class ProductDioRepository {
  Future<Courses> findByName(String name) async {
    try {
      final response = await Dio().get(
        'http://localhost:8080/products',
        queryParameters: {
          'name': name,
        },
      );

      if (response.data.isEmpty) {
        throw Exception('Produto não encontrado');
      }

      return Courses.fromMap(response.data.first);
    } on DioException {
      throw Exception();
    }
  }
}

// Implementación de mi datasource definido en el dominio

import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/auth/domain/datasources/auth_datasource.dart';
import 'package:teslo_shop/features/auth/domain/entities/user.dart';
import 'package:teslo_shop/features/auth/infrastructure/errors/auth_errors.dart';
import 'package:teslo_shop/features/auth/infrastructure/mappers/user_mapper.dart';

class AuthDatasourceImpl extends AuthDataSource {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await dio.get('/auth/check-status', options: Options(headers: {'Authorization': 'Bearer $token'}));
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      // if (e.response?.statusCode == 401) throw WrongCredentials();
      if (e.response?.statusCode == 401) {
        throw CustomError('Token incorrecto');
      }
      // if (e.type == DioExceptionType.connectionTimeout) throw ConnectionTimeout();
      if (e.type == DioExceptionType.connectionTimeout) throw CustomError('Revisar conexión a internet');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post('/auth/login', data: {'email': email, 'password': password});
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      // if (e.response?.statusCode == 401) throw WrongCredentials();
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data['message'] ?? 'Credenciales incorrectas');
      }
      // if (e.type == DioExceptionType.connectionTimeout) throw ConnectionTimeout();
      if (e.type == DioExceptionType.connectionTimeout) throw CustomError('Revisar conexión a internet');
      throw Exception();
    } catch (e) {
      // throw CustomError('Something wrong happpend');
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) async {
    try {
      final response = await dio.post('/auth/register', data: {'email': email, 'password': password, 'fullName': fullName});
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError(e.response?.data['message'] ?? 'Error en el registro');
      }
      if (e.type == DioExceptionType.connectionTimeout) throw CustomError('Revisar conexión a internet');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}

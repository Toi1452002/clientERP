import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/system/users/data/model/user_add_model.dart';
import 'package:erp_client_1/features/system/users/data/model/user_changed_info_model.dart';
import 'package:erp_client_1/features/system/users/data/model/user_edit_model.dart';
import 'package:erp_client_1/features/system/users/data/model/user_update_model.dart';
import 'package:erp_client_1/features/system/users/data/model/user_view_model.dart';
import 'package:erp_client_1/features/system/users/data/repository/iuser_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/data/network/network_exception.dart';
import '../../../auth/data/model/auth_info_model.dart';

final userRepositoryProvider = Provider<IUserRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return UserRepository(dio);
});

class UserRepository implements IUserRepository {
  final Dio _dio;

  UserRepository(this._dio);

  @override
  Future<UserViewModel> add(UserAddModel user) async {
    // TODO: implement add
    try {
      final response = await _dio.post("/user", data: user.toMap());
      final data = response.data as Map<String, dynamic>;
      return UserViewModel.fromMap(data);
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }

  @override
  Future<int> delete(int id) async {
    // TODO: implement delete
    try {
      final response = await _dio.delete("/user/$id");
      return response.data;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }

  @override
  Future<UserEditModel> getEdit(int id) async {
    // TODO: implement getEdit
    try {
      final response = await _dio.get("/user/$id");
      final data = response.data as Map<String, dynamic>;
      return UserEditModel.fromMap(data);
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }

  @override
  Future<List<UserViewModel>> getView() async {
    // TODO: implement getView
    try {
      final response = await _dio.get("/user");
      final data = response.data as List;
      return data.map((e) => UserViewModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }

  @override
  Future<UserViewModel> update(UserUpdateModel user, int id) async {
    // TODO: implement update
    try {
      final response = await _dio.put("/user/$id", data: user.toMap());
      final data = response.data as Map<String, dynamic>;
      return UserViewModel.fromMap(data);
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }

  @override
  Future<void> updatePassword(String password, int id) async {
    // TODO: implement updatePassword
    try {
      await _dio.patch("/user/$id", queryParameters: {"password": password});
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }

  @override
  Future<int> changeInfoUser(UserChangedInfoModel model) async{
    // TODO: implement changeInfoUser
    try {
      final response = await _dio.put("/user/change-info", data: model.toMap());
      return response.data;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }
}

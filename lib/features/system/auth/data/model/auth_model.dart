import 'package:erp_client_1/features/system/auth/data/model/auth_info_model.dart';

class AuthModel {
  final String accessToken;
  final String refreshToken;
  final AuthInfoModel? info;

  const AuthModel({required this.accessToken, required this.refreshToken, required this.info});

  // Map<String, dynamic> toMap() {
  //   return {'accessToken': this.accessToken, 'refreshToken': this.refreshToken, 'info': this.info};
  // }

  // factory AuthModel.fromMap(Map<String, dynamic> map) {
  //   return AuthModel(accessToken: map['accessToken'], refreshToken: map['refreshToken'], info: map['info']);
  // }

  AuthModel copyWith({
    String? accessToken,
    String? refreshToken,
    AuthInfoModel? info,
  }) {
    return AuthModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      info: info ?? this.info,
    );
  }
}

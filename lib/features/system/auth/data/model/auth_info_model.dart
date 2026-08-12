class AuthInfoModel {
  final String username;
  final int roleId;
  final String fullName;

  const AuthInfoModel({
    required this.username,
    required this.roleId,
    required this.fullName,
  });


  factory AuthInfoModel.fromMap(Map<String, dynamic> map) {
    return AuthInfoModel(
      username: map['username'],
      roleId: map['roleId'],
      fullName: map['fullName'],
    );
  }

}
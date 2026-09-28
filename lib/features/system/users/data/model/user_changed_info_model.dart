class UserChangedInfoModel{
  final String oldUsername;
  final String newUsername;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const UserChangedInfoModel({
    required this.oldUsername,
    required this.newUsername,
    required this.oldPassword,
    required this.newPassword, required this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'oldUsername': oldUsername,
      'newUsername': newUsername,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }

  // factory UserChangedInfoModel.fromMap(Map<String, dynamic> map) {
  //   return UserChangedInfoModel(
  //     oldUsername: map['oldUsername'] as String,
  //     newUsername: map['newUsername'] as String,
  //     oldPassword: map['oldPassword'] as String,
  //     newPassword: map['newPassword'] as String,
  //   );
  // }

}
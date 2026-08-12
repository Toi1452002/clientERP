class UserUpdateModel{
  final String username;
  final String fullName;
  final String? phone;
  final String? email;
  final String? address;
  final String? note;
  final int roleId;

  const UserUpdateModel({
    required this.username,
    required this.fullName,
    this.phone,
    this.email,
    this.address,
    this.note,
    required this.roleId,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'fullName': fullName,
      'phone': phone,
      'email': email,
      'address': address,
      'note': note,
      'roleId': roleId,
    };
  }

}
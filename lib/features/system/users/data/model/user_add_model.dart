class UserAddModel{
  final String username;
  final String password;
  final String fullName;
  final String? phone;
  final String? email;
  final String? address;
  final String? note;
  final int roleId;

  const UserAddModel({
    required this.username,
    required this.password,
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
      'password': password,
      'fullName': fullName,
      'phone': phone,
      'email': email,
      'address': address,
      'note': note,
      'roleId': roleId,
    };
  }
}
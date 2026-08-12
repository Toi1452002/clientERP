class UserEditModel {
  final int? id;
  final String username;
  final String fullName;
  final String? phone;
  final String? email;
  final String? address;
  final String? note;
  final int roleId;

  const UserEditModel({
    this.id,
    required this.username,
    required this.fullName,
    this.phone,
    this.email,
    this.address,
    this.note,
    required this.roleId,
  });

  factory UserEditModel.fromMap(Map<String, dynamic> map) {
    return UserEditModel(
      id: map['id'],
      username: map['username'],
      fullName: map['fullName'],
      phone: map['phone'] ,
      email: map['email'] ,
      address: map['address'],
      note: map['note'],
      roleId: map['roleId'] ,
    );
  }
}
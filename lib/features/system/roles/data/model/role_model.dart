class RoleModel{
  final int id;
  final String roleName;

  const RoleModel({
    required this.id,
    required this.roleName,
  });

  factory RoleModel.fromMap(Map<String, dynamic> map) {
    return RoleModel(
      id: map['id'] ,
      roleName: map['roleName'],
    );
  }

  RoleModel copyWith({
    int? id,
    String? roleName,
  }) {
    return RoleModel(
      id: id ?? this.id,
      roleName: roleName ?? this.roleName,
    );
  }

}
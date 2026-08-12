class AuthMenuModel {
  final int id;
  final int? parentId;
  final String code;
  final String name;
  final int sortOrder;

  const AuthMenuModel({
    required this.id,
    required this.parentId,
    required this.code,
    required this.name,
    required this.sortOrder,
  });

  factory AuthMenuModel.fromMap(Map<String, dynamic> map) {
    return AuthMenuModel(
      id: map['id'] as int,
      parentId: map['parentId'] as int?,
      code: map['code'] as String,
      name: map['name'] as String,
      sortOrder: map['sortOrder'] as int,
    );
  }
}
class MenuPermissionModel {
  final int id;
  final String treeName;
  final int level;
  final bool choPhep;

  MenuPermissionModel({required this.id, required this.treeName, required this.choPhep, required this.level});

  factory MenuPermissionModel.fromMap(Map<String, dynamic> map) {
    return MenuPermissionModel(
      id: map['id'] as int,
      treeName: map['treeName'] as String,
      choPhep: map['status'] == 0,
      level: map['level'],
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {'id': id};
  // }
}

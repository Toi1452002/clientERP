class DvtModel{
  final int id;
  final String dvt;

  const DvtModel({
    required this.id,
    required this.dvt,
  });


  factory DvtModel.fromMap(Map<String, dynamic> map) {
    return DvtModel(
      id: map['id'] as int,
      dvt: map['dvt'] as String,
    );
  }

  DvtModel copyWith({
    int? id,
    String? dvt,
  }) {
    return DvtModel(
      id: id ?? this.id,
      dvt: dvt ?? this.dvt,
    );
  }

}
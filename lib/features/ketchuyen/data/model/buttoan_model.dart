class ButToanModel{
  final String ma;
  final String butToan;

  const ButToanModel({
    required this.ma,
    required this.butToan,
  });


  factory ButToanModel.fromMap(Map<String, dynamic> map) {
    return ButToanModel(
      ma: map['ma'] ,
      butToan: map['butToan'] ,
    );
  }

}
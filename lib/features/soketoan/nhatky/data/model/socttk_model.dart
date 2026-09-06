class SoCTTKModel{
  final DateTime ngay;
  final DateTime ngayCT;
  final String chungTu;
  final String? dienGiai;
  final String tkdu;
  final num psNo;
  final num psCo; 
  final num soDuNo;
  final num soDuCo;

  const SoCTTKModel({
    required this.ngay,
    required this.ngayCT,
    required this.chungTu,
    this.dienGiai,
    required this.tkdu,
    required this.psNo,
    required this.psCo,
    required this.soDuNo,
    required this.soDuCo,
  });


  factory SoCTTKModel.fromMap(Map<String, dynamic> map) {
    return SoCTTKModel(
      ngay: DateTime.parse(map['ngay']) ,
      ngayCT: DateTime.parse(map['ngayCT']) ,
      chungTu: map['chungTu'] ,
      dienGiai: map['dienGiai'] ,
      tkdu: map['tkdu'] ,
      psNo: map['psNo'] ,
      psCo: map['psCo'] ,
      soDuNo: map['soDuNo'] ,
      soDuCo: map['soDuCo'] ,
    );
  }
}

class SoCTTKViewModel{
  final List<SoCTTKModel> soCTTK;
  final num dkNo;
  final num dkCo;
  final num ckNo;
  final num ckCo;

  const SoCTTKViewModel({
    required this.soCTTK,
    required this.dkNo,
    required this.dkCo,
    required this.ckNo,
    required this.ckCo,
  });


  factory SoCTTKViewModel.fromMap(Map<String, dynamic> map) {
    final soCTTK = map['soCTTK'] as List;
    return SoCTTKViewModel(
      soCTTK: soCTTK.map((e)=>SoCTTKModel.fromMap(e)).toList(),
      dkNo: map['dkNo'] ,
      dkCo: map['dkCo'] ,
      ckNo: map['ckNo'] ,
      ckCo: map['ckCo'] ,
    );
  }}
import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_alert.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/features/danhmuc/dvt/presentation/dialog/dvt_dialog.dart';
import 'package:erp_client_1/features/danhmuc/dvt/presentation/notifier/dvt_notifier.dart';
import 'package:erp_client_1/features/danhmuc/nhomhang/presentation/dialog/nhomhang_dialog.dart';
import 'package:erp_client_1/features/danhmuc/nhomhang/presentation/notifier/nhomhang_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/utils/num_helper.dart';
import '../../../../../../core/widgets/app_button.dart';
import '../../../../../../core/widgets/app_row.dart';
import '../../../../../../core/widgets/app_textfield.dart';
import 'package:collection/collection.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../dvt/presentation/ui/widget/dvt_combobox.dart';
import '../../../khach/presentation/ui/widget/nhacung_combobox.dart';
import '../../../nhomhang/presentation/ui/widget/nhomhang_combobox.dart';
import '../../../taikhoan/presentation/ui/widget/taikhoan_kho_combobox.dart';
import '../../data/model/hanghoa_model.dart';
import '../notifier/hanghoa_edit_notifier.dart';
import '../notifier/hanghoa_view_notifierr.dart';
import '../ui/widget/loaihang_combobox.dart';

class HangHoaFormDialog extends ConsumerStatefulWidget {
  final int? id;

  const HangHoaFormDialog({super.key, this.id});

  @override
  ConsumerState createState() => _HangHoaFormDialogState();
}

class _HangHoaFormDialogState extends ConsumerState<HangHoaFormDialog> {
  final txtMaHH = TextEditingController();
  final txtTenHH = TextEditingController();
  final txtGiaMua = TextEditingController();
  final txtGiaBan = TextEditingController();
  final txtGhiChu = TextEditingController();
  int? loaiHang;
  String? dvt;
  String? nhomHang;
  String? maNC;
  String khoNgamDinh = "156";
  bool tinhToanTonKho = false;
  bool theoDoi = true;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      loadHangHoa(widget.id!);
    }

    ref.listenManual(hangHoaEditProvider, (pre, next) {
      next.whenOrNull(
        data: (v) {
          context.pop();
          ref.invalidate(hangHoaViewProvider);
        },
        error: (e, s) {
          showInfo(context, e.toString());
        },
      );
    });
  }

  HangHoaModel _hangHoaModel() {
    final donViTinh = ref.read(dvtProvider).value?.firstWhereOrNull((e) => e.dvt == dvt);
    final nh = ref.read(nhomhangProvider).value?.firstWhereOrNull((e) => e.nhomHang == nhomHang);
    return HangHoaModel(
      maHH: txtMaHH.text.trim(),
      tenHH: txtTenHH.text.trim(),
      giaMua: NumHelper.stringToDouble(txtGiaMua.text),
      giaBan: NumHelper.stringToDouble(txtGiaBan.text),
      tinhTon: tinhToanTonKho,
      isActive: theoDoi,
      tkKho: khoNgamDinh,
      ghiChu: txtGhiChu.text,
      maNhaCung: maNC,
      dvtId: donViTinh?.id,
      loaiHHId: loaiHang,
      nhomId: nh?.id,
    );
  }

  Future<void> loadHangHoa(int id) async {
    final hangHoa = await ref.read(hangHoaEditProvider.notifier).getById(id);
    if (hangHoa != null) {
      final donViTinh = hangHoa.dvtId == null
          ? null
          : ref.read(dvtProvider).value?.firstWhereOrNull((e) => e.id == hangHoa.dvtId);
      final nh = hangHoa.nhomId == null
          ? null
          : ref.read(nhomhangProvider).value?.firstWhereOrNull((e) => e.id == hangHoa.nhomId);

      txtMaHH.text = hangHoa.maHH;
      txtTenHH.text = hangHoa.tenHH;
      loaiHang = hangHoa.loaiHHId;
      dvt = donViTinh?.dvt;
      nhomHang = nh?.nhomHang;
      maNC = hangHoa.maNhaCung;
      khoNgamDinh = hangHoa.tkKho;
      txtGiaMua.text = NumHelper.numFormat(hangHoa.giaMua);
      txtGiaBan.text = NumHelper.numFormat(hangHoa.giaBan);
      txtGhiChu.text = hangHoa.ghiChu ?? '';
      tinhToanTonKho = hangHoa.tinhTon;
      theoDoi = hangHoa.isActive;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hangHoaEditProvider);
    return DialogWindows(
      width: 600,
      height: 340,
      title: 'THÔNG TIN HÀNG HÓA',
      child: LoadingOverlay(
        isLoading: state.isLoading,
        child: Scaffold(
          // backgroundColor: AppColor.background,
          footers: [
            Divider(color: AppColor.border300,),
            AppBar(
              trailing: [

                AppSaveButton(
                  // text: 'Lưu',
                  onPressed: () async {
                    if (widget.id == null) {
                      ref.read(hangHoaEditProvider.notifier).addHangHoa(_hangHoaModel());
                    } else {
                      ref.read(hangHoaEditProvider.notifier).updateHangHoa(_hangHoaModel(), widget.id!);
                    }
                  },
                ),
              ],
            )
          ],
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                AppRow(
                  columnWidths: {0: 80, 1: 180, 3: 180},
                  items: [
                    Text('Mã hàng'),
                    AppTextField(controller: txtMaHH),
                    Row(children: [Gap(10), Text('Loại hàng')]),
                    LoaiHangCombobox(
                      selected: loaiHang,
                      onChanged: (val) {
                        setState(() {
                          loaiHang = val;
                        });
                      },
                    ),
                  ],
                ),
                AppRow(
                  columnWidths: {0: 80},
                  items: [
                    Text('Tên hàng'),
                    AppTextField(controller: txtTenHH),
                  ],
                ),
                AppRow(
                  columnWidths: {0: 80, 1: 150, 2: 30, 4: 150, 5: 30},
                  items: [
                    Text('Đơn vị tính'),
                    DvtCombobox(
                      selected: dvt,
                      onChanged: (val) {
                        setState(() {
                          dvt = val;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Gap(5),
                        AppAddButton(
                          onPressed: () {
                            showAppDialog(context, child: DvtDialog());
                          },
                        ),
                      ],
                    ),

                    Row(children: [Gap(10), Text('Nhóm hàng')]),
                    NhomHangCombobox(
                      onChanged: (val) {
                        setState(() {
                          nhomHang = val;
                        });
                      },
                      selected: nhomHang,
                    ),
                    Row(
                      children: [
                        Gap(5),
                        AppAddButton(
                          onPressed: () {
                            showAppDialog(context, child: NhomHangDialog());
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                AppRow(
                  columnWidths: {0: 80, 1: 180, 3: 180},
                  items: [
                    Text('Nhà cung'),
                    NhaCungCombobx(
                      selected: maNC,
                      onChanged: (val) {
                        setState(() {
                          maNC = val;
                        });
                      },
                    ),
                    Row(children: [Gap(10), Text('Kho ngầm định')]),
                    TaiKhoanKhoCombobox(
                      selected: khoNgamDinh,
                      onChanged: (val) {
                        setState(() {
                          khoNgamDinh = val;
                        });
                      },
                    ),
                  ],
                ),

                AppRow(
                  columnWidths: {0: 80, 1: 180, 3: 180},
                  items: [
                    Text('Giá mua'),

                    AppTextField(
                      isNumber: true,
                      textAlign: TextAlign.end,
                      controller: txtGiaMua,
                      onFieldLeave: () {
                        txtGiaMua.text = NumHelper.numFormat(txtGiaMua.text);
                      },
                    ),
                    Row(children: [Gap(10), Text('Giá bán')]),

                    AppTextField(
                      // focusNode: focusGiaBan,
                      onFieldLeave: () {
                        txtGiaBan.text = NumHelper.numFormat(txtGiaBan.text);
                      },
                      isNumber: true,
                      textAlign: TextAlign.end,
                      controller: txtGiaBan,
                    ),
                  ],
                ),

                AppRow(
                  columnWidths: {0: 80},
                  items: [
                    Text('Ghi chú'),
                    AppTextField(controller: txtGhiChu),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Checkbox(
                      state: tinhToanTonKho ? CheckboxState.checked : CheckboxState.unchecked,
                      onChanged: (val) {
                        setState(() {
                          tinhToanTonKho = val.index == 0;
                        });
                      },
                      trailing: Text('Tính toán tồn kho'),
                    ),
                    Checkbox(
                      state: theoDoi ? CheckboxState.checked : CheckboxState.unchecked,
                      onChanged: (val) {
                        setState(() {
                          theoDoi = val.index == 0;
                        });
                      },
                      trailing: Text('Mặc hàng đang theo dõi'),
                    ),
                  ],
                ),
                // Spacer(),
                // Row(
                //   spacing: 10,
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     AppSaveButton(
                //       // text: 'Lưu',
                //       onPressed: () async {
                //         if (widget.id == null) {
                //           ref.read(hangHoaEditProvider.notifier).addHangHoa(_hangHoaModel());
                //         } else {
                //           ref.read(hangHoaEditProvider.notifier).updateHangHoa(_hangHoaModel(), widget.id!);
                //         }
                //       },
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

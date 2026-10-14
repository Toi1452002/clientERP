import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/shortcut/shortcut_config.dart';
import 'package:erp_client_1/core/widgets/widget.dart';
import 'package:erp_client_1/features/danhmuc/dvt/presentation/notifier/dvt_notifier.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/presentation/notifier/hanghoa_get_edit_notifier.dart';
import 'package:erp_client_1/features/danhmuc/nhomhang/presentation/notifier/nhomhang_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/utils/num_helper.dart';
import 'package:collection/collection.dart';

import '../../../../../core/shortcut/Shortcut_intent.dart';
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


  bool themTiep = false;
  final _maHHFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      ref.read(hangHoaGetEditProvider.notifier).get(id:widget.id);
    });

    ref.listenManual(hangHoaGetEditProvider, (_,next){
      next.whenOrNull(
        data: (val){
          if(val!=null){
            loadHangHoa(val);
          }
        },
        error: (e,s){
          showInfo(context, e.toString());
        }
      );
    });

    ref.listenManual(hangHoaEditProvider, (pre, next) {
      next.whenOrNull(
        data: (val) {
          if(val!=null){
            if(widget.id==null){
              ref.read(hangHoaViewProvider.notifier).add(val);
            }else{
              ref.read(hangHoaViewProvider.notifier).updateRow(val);
            }

            if(!themTiep){
              context.pop();
            }else{
              clear();
              _maHHFocus.requestFocus();
            }

          }

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

  void loadHangHoa(HangHoaModel hangHoa)  {
    // final hangHoa = await ref.read(hangHoaEditProvider.notifier).getById(id);
    // if (hangHoa != null) {
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
    // }
  }

  void clear(){
    txtMaHH.clear();
    txtTenHH.clear();
    loaiHang =null;
    dvt = null;
    nhomHang = null;
    maNC = null;
    khoNgamDinh = '156';
    txtGiaMua.clear();
    txtGiaBan.clear();
    txtGhiChu.clear();
    tinhToanTonKho = false;
    theoDoi = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hangHoaEditProvider);
    final getState = ref.watch(hangHoaGetEditProvider);
    return Shortcuts(
      shortcuts: ShortcutConfig.shortcut,
      child: Actions(
        actions: {
          SaveAndCloseIntent: CallbackAction<SaveAndCloseIntent>(
            onInvoke: (SaveAndCloseIntent intent) {
              themTiep = false;
              if (widget.id == null) {
                ref.read(hangHoaEditProvider.notifier).addHangHoa(_hangHoaModel());
              } else {
                ref.read(hangHoaEditProvider.notifier).updateHangHoa(_hangHoaModel(), widget.id!);
              }
              return null;
            },
          ),
          SaveConfirmIntent: CallbackAction<SaveConfirmIntent>(
            onInvoke: (SaveConfirmIntent intent) {
              if (widget.id == null) {
                themTiep = true;
                ref.read(hangHoaEditProvider.notifier).addHangHoa(_hangHoaModel());
              }

              return null;
            },
          ),
        },
        child: DialogWindows(
          width: 600,
          height: 340,
          title: 'THÔNG TIN HÀNG HÓA',
          child: AppLoadingOverlay(
            isLoading: state.isLoading || getState.isLoading,
            child: Scaffold(
              // backgroundColor: AppColor.background,
              footers: [
                Divider(color: AppColor.border300),
                AppBar(
                  leading: [if (state.hasError) Text(state.error.toString(), style: TextStyle(color: Colors.red))],

                  trailing: [
                    AppSaveButton(
                      text: 'Lưu & đóng',
                      onPressed: () async {
                        themTiep=false;
                        if (widget.id == null) {
                          ref.read(hangHoaEditProvider.notifier).addHangHoa(_hangHoaModel());
                        } else {
                          ref.read(hangHoaEditProvider.notifier).updateHangHoa(_hangHoaModel(), widget.id!);
                        }
                      },
                    ),
                    if(widget.id==null) AppSaveButton(
                      text: 'Lưu',
                      onPressed: (){
                        themTiep = true;
                        ref.read(hangHoaEditProvider.notifier).addHangHoa(_hangHoaModel());
                      },
                    )
                  ],
                ),
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
                        Text('Mã hàng').medium,
                        AppTextField(controller: txtMaHH,autofocus: true,focusNode: _maHHFocus,),
                        Row(children: [Gap(10), Text('Loại hàng').medium]),
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
                        Text('Tên hàng').medium,
                        AppTextField(controller: txtTenHH),
                      ],
                    ),
                    AppRow(
                      columnWidths: {0: 80, 1: 180, 3: 180},
                      items: [
                        Text('Đơn vị tính').medium,
                        DvtCombobox(
                          selected: dvt,
                          showAdd: true,
                          onChanged: (val) {
                            setState(() {
                              dvt = val;
                            });
                          },
                        ),

                        Row(children: [Gap(10), Text('Nhóm hàng').medium]),
                        NhomHangCombobox(
                          onChanged: (val) {
                            setState(() {
                              nhomHang = val;
                            });
                          },
                          selected: nhomHang,
                        ),
                      ],
                    ),

                    AppRow(
                      columnWidths: {0: 80, 1: 180, 3: 180},
                      items: [
                        Text('Nhà cung').medium,
                        NhaCungCombobx(
                          selected: maNC,
                          onChanged: (val) {
                            setState(() {
                              maNC = val;
                            });
                          },
                        ),
                        Row(children: [Gap(10), Text('Kho ngầm định').medium]),
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
                        Text('Giá mua').medium,

                        AppTextField(
                          isNumber: true,
                          textAlign: TextAlign.end,
                          controller: txtGiaMua,
                          onFieldLeave: () {
                            txtGiaMua.text = NumHelper.numFormat(txtGiaMua.text);
                          },
                        ),
                        Row(children: [Gap(10), Text('Giá bán').medium]),

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
                        Text('Ghi chú').medium,
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
        ),
      ),
    );
  }
}

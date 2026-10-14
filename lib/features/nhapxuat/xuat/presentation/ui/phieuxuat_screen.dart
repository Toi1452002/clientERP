import 'package:collection/collection.dart';
import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/utils/num_helper.dart';
import 'package:erp_client_1/features/danhmuc/khach/data/model/khach_lookup_model.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/ui/state/khach_lookup_state.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/ui/widget/khach_combobox.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/ui/widget/taikhoan_xl0_combobox.dart';
import 'package:erp_client_1/features/danhmuc/thuesuat/presentation/ui/widget/thuesuat_combobox.dart';
import 'package:erp_client_1/features/nhapxuat/xuat/presentation/ui/state/phieuxuatct_table_manager.dart';
import 'package:erp_client_1/features/nhapxuat/xuat/presentation/ui/widget/phieuxuatct_table.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shortcut/Shortcut_intent.dart';
import '../../../../../core/shortcut/shortcut_config.dart';
import '../../../../../core/widgets/widget.dart';
import '../../../../danhmuc/manghiepvu/presentation/ui/widget/nvu_xuat_combobox.dart';
import '../../../../report/presentation/dialog/report_dialog.dart';
import '../../../../report/presentation/notifier/report_notifier.dart';
import '../../data/model/phieuxuat_request_model.dart';
import '../../data/model/phieuxuat_save_model.dart';
import '../../data/model/phieuxuat_update_model.dart';
import '../notifier/phieuxuat_delete_notifier.dart';
import '../notifier/phieuxuat_notifier.dart';
import '../notifier/phieuxuat_save_notifier.dart';

class PhieuXuatScreen extends ConsumerStatefulWidget {
  final String? phieu;

  const PhieuXuatScreen({super.key, this.phieu});

  @override
  ConsumerState createState() => _PhieuXuatScreenState();
}

class _PhieuXuatScreenState extends ConsumerState<PhieuXuatScreen> {
  DateTime? ngay;
  DateTime? ngayHoaDon;

  String maNX = "NM";
  String pttt = "TM";
  String? maKH;
  String? tkNo;
  String? tkCo;
  String? tkVatNo;
  String? tkVatCo;
  int? thueSuat;
  bool khoa = false;
  bool isNull = true;
  String? index;
  String? total;
  int id = 0;

  final txtSoPhieu = TextEditingController();
  final txtKyHieu = TextEditingController();
  final txtTenKH = TextEditingController();
  final txtSoHD = TextEditingController();
  final txtDienGiai = TextEditingController();

  String tongTienHang = '0';
  String tienThue = '0';
  String tongThanhToan = '0';

  late PhieuXuatCTTableManager _tableManager;

  bool isSave = false;
  bool isUpdateKhoa = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.phieu != null) {
        ref.read(phieuXuatProvider.notifier).getByPhieu(widget.phieu!);
      } else {
        ref.read(phieuXuatProvider.notifier).rebuild();
      }
    });

    ref.listenManual(phieuXuatProvider, (pre, next) {
      next.whenOrNull(
        data: (val) {
          setValue(val);
        },
      );
    });

    ref.listenManual(phieuXuatSaveProvider, (pre, next) {
      next.whenOrNull(
        data: (val) {
          if (isSave) {
            setState(() {
              khoa = true;
              isSave = false;
            });
          }

          if(isUpdateKhoa){
            setState(() {
              khoa = !khoa;
              isUpdateKhoa = false;
            });
          }
        },
        error: (e, s) {
          showInfo(context, e.toString());
        },
      );
    });

    ref.listenManual(phieuXuatDeleteProvider, (pre, next) {
      next.whenOrNull(
        data: (val) {
          ref.read(phieuXuatProvider.notifier).getNext();
        },
        error: (e, s) {
          showInfo(context, e.toString());
        },
      );
    });
  }

  Future<void> setValue(PhieuXuatRequestModel? x) async {
    if (x == null) {
      txtSoPhieu.clear();
      return;
    }
    final p = x.phieuXuat;
    final khachState = await ref.read(khachLookupProvider(LoaiKH.Khach).future);
    final khach = khachState.firstWhereOrNull((e) => e.maKH == p.maKH);
    txtSoPhieu.text = p.phieu;
    id = p.id!;
    ngay = p.ngay;
    ngayHoaDon = p.ngayCT;
    maNX = p.maNX;
    txtKyHieu.text = p.kyHieu ?? "";
    txtSoHD.text = p.soHD ?? "";
    pttt = p.pttt;
    maKH = p.maKH;
    khoa = p.khoa;
    txtTenKH.text = khach == null ? "" : khach.tenKH;
    txtDienGiai.text = p.dienGiai ?? "";
    tkNo = p.tkNo;
    tkCo = p.tkCo;
    tkVatNo = p.tkVatNo;
    tkVatCo = p.tkVatCo;
    thueSuat = p.thueSuat;
    tongTienHang = NumHelper.numFormat(p.congTien);
    tienThue = NumHelper.numFormat(p.tienThue);
    tongThanhToan = NumHelper.numFormat((p.congTien ?? 0) + (p.tienThue ?? 0));

    setState(() {});
  }

  PhieuXuatSaveModel _model() {
    return PhieuXuatSaveModel(
      soHD: txtSoHD.text.isEmpty ? null : txtSoHD.text,
      maKH: maKH,
      tienThue: NumHelper.stringToDouble(tienThue),
      congTien: NumHelper.stringToDouble(tongTienHang),
      dienGiai: txtDienGiai.text,
      kyHieu: txtKyHieu.text,
      ngay: ngay,
      ngayCT: ngayHoaDon,
      thueSuat: thueSuat,
      maNX: maNX,
      tkNo: tkNo,
      tkCo: tkCo,
      tkVatNo: tkVatNo,
      tkVatCo: tkVatCo,
      pttt: pttt,
    );
  }

  void _autoSave(){
    if(!khoa){
      ref
          .read(phieuXuatSaveProvider.notifier)
          .save(PhieuXuatUpdateModel(phieuXuat: _model(), phieuXuatCT: _tableManager.toList(id)), id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(phieuXuatProvider);
    final stateSave = ref.watch(phieuXuatSaveProvider);
    final stateDelete = ref.watch(phieuXuatDeleteProvider);
    return Shortcuts(
      shortcuts: ShortcutConfig.shortcut,
      child: Actions(
        actions: {
          SaveIntent: CallbackAction<SaveIntent>(
            onInvoke: (SaveIntent intent) {
              isSave = true;
              _autoSave();
              return null;
            },
          ),
          EditIntent: CallbackAction<EditIntent>(
            onInvoke: (EditIntent intent) {
              if(khoa){
                ref.read(phieuXuatSaveProvider.notifier).updateKhoa(id);
                isUpdateKhoa = true;
              }
              return null;
            },
          ),
          NewIntent: CallbackAction<NewIntent>(
            onInvoke: (NewIntent intent) {
              _autoSave();
              ref.read(phieuXuatProvider.notifier).addPhieu();
              return null;
            },
          ),
          DeleteIntent: CallbackAction<DeleteIntent>(
            onInvoke: (DeleteIntent intent) {
              if(!khoa && state.value != null){
                showQuestion(context,onPressed: (){
                  ref.read(phieuXuatDeleteProvider.notifier).delete(id);
                });
              }
              return null;
            },
          ),
        },
        child: DialogWindows(
          width: 1150,
          height: 600,
          beforeClose: () async {
            if (!khoa && state.value != null) {
              showClosePhieu(
                context,
                onPressed: () {

                  _autoSave();
                  Navigator.pop(context);
                },
              );
            } else {
              Navigator.pop(context);
            }
          },
          title: 'PHIẾU XUẤT BÁN HÀNG HÓA',
          child: Scaffold(
            backgroundColor: AppColor.background,
            footers: [
              Divider(color: AppColor.border300),

              AppBar(
                leading: [
                  AppButtonPage(
                    first: () {
                      _autoSave();
                      ref.read(phieuXuatProvider.notifier).getFirst();
                    },
                    last: () {
                      _autoSave();
                      ref.read(phieuXuatProvider.notifier).rebuild();
                    },
                    back: () {
                      _autoSave();
                      ref.read(phieuXuatProvider.notifier).getPrevious();
                    },
                    next: () {
                      _autoSave();
                      ref.read(phieuXuatProvider.notifier).getNext();
                    },
                    firstText: state.hasValue ? "${state.value?.phieuXuat.stt ?? '0'}" : '0',
                    secondText: state.hasValue ? "${state.value?.phieuXuat.tongStt ?? '0'}" : '0',
                  ),
                ],
              ),
            ],
            headers: [
              AppBar(
                leading: [
                  Focus(
                    autofocus: true,
                    child: AppNewButton(
                      text: 'Phiếu mới',
                      onPressed: () {
                        ref.read(phieuXuatProvider.notifier).addPhieu();
                        _autoSave();


                      },
                    ),
                  ),
                  Gap(5),
                  AppSaveButton(
                    enabled: !khoa && state.value != null,
                    onPressed: () {
                      ref
                          .read(phieuXuatSaveProvider.notifier)
                          .save(PhieuXuatUpdateModel(phieuXuat: _model(), phieuXuatCT: _tableManager.toList(id)), id);
                      isSave = true;
                    },
                  ),
                  Gap(5),
                  AppEditButton(
                    enabled: khoa,
                    onPressed: () {
                      ref.read(phieuXuatSaveProvider.notifier).updateKhoa(id);
                      isUpdateKhoa = true;
                    },
                  ),
                  Gap(5),
                  AppDeleteButton(
                    enabled: state.value != null && !khoa,
                    onPressed: () {
                      showQuestion(
                        context,
                        onPressed: () {
                          ref.read(phieuXuatDeleteProvider.notifier).delete(id);
                        },
                      );
                    },
                  ),
                  Gap(5),
                  AppPrintButton(enabled: khoa,onPressed: () async {
                    ref.read(reportProvider.notifier).getPhieuXuat(id);
                    // showAppDialog(context, child: ReportDialog());
                    await showPrinter(context, ref);

                  },),
                ],
              ),
              Divider(color: AppColor.border300),
            ],
            child: state.when(
              data: (val) {
                if (val == null) {
                  return Center(
                    child: Text('Chưa có phiếu xuất', style: TextStyle(color: Colors.gray)),
                  );
                }
                return AppLoadingOverlay(
                  isLoading: stateSave.isLoading || stateDelete.isLoading,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Column(
                        spacing: 10,
                        children: [
                          OutlinedContainer(
                            borderColor: AppColor.border300,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 10,
                              children: [
                                AppRow(
                                  columnWidths: {0: 80,1:160, 2: 100, 4: 125,5:140,6:150},
                                  items: [
                                    Text('Ngày').medium,
                                    AppDateField(
                                      enabled: !khoa,
                                      value: ngay,
                                      onChanged: (val) async {
                                        ngay = val;
                                        ngayHoaDon = val;
                                        // await updateNgay(val, ref.read(userLoginProvider)!.userName);
                                        setState(() {});
                                      },
                                    ),
                                    Row(children: [Gap(30), Text('Số phiếu').medium]),
                                    AppTextField(enabled: !khoa, controller: txtSoPhieu, readOnly: true,fontWeight: FontWeight.w500,),
                                    Row(children: [Gap(30), Text('Kiểu xuất').medium]),
                                    NvuXuatCombobox(
                                      enabled: !khoa,
                                      selected: maNX,
                                      onChanged: (val) {
                                        setState(() {
                                          maNX = val;
                                        });
                                      },
                                    ),
                                    Row(children: [Gap(30), Text('Ký hiệu hóa đơn').medium]),
                                    AppTextField(
                                      enabled: !khoa,
                                      onFieldLeave: () async {
                                        // await updateKyHieu(txtKyHieu.text,user);
                                      },
                                      controller: txtKyHieu,
                                    ),
                                    // SizedBox()
                                    // Row(
                                    //   children: [
                                    //     Gap(10),
                                    //     AppCombobox(
                                    //       enabledClear: false,
                                    //       enabled: !khoa,
                                    //       value: pttt,
                                    //       onChanged: (val) async {
                                    //         // await updatePTTT(val,user);
                                    //         setState(() {
                                    //           pttt = val;
                                    //         });
                                    //       },
                                    //       items: [
                                    //         ComboboxItem(value: 'TM', text: ["TM"]),
                                    //         ComboboxItem(value: 'CK', text: ["CK"]),
                                    //       ],
                                    //     ).expanded(),
                                    //   ],
                                    // ),
                                  ],
                                ),
                                AppRow(
                                  columnWidths: {0: 80, 1: 160, 2: 530, 3: 150},
                                  items: [
                                    Text('Mã khách').medium,
                                    KhachCombobox(
                                      selected: maKH,
                                      enabled: !khoa,
                                      onChanged: (val) {
                                        final kh = ref
                                            .read(khachLookupProvider(LoaiKH.Khach))
                                            .value
                                            ?.firstWhereOrNull((e) => e.maKH == val);
                                        if (kh != null) {
                                          txtTenKH.text = kh.tenKH;
                                          txtDienGiai.text = "Bán hàng cho khách $val";
                                        } else {
                                          txtTenKH.clear();
                                          txtDienGiai.clear();
                                        }
                                        setState(() {
                                          maKH = val;
                                        });
                                      },
                                    ),
                                    Row(
                                      children: [
                                        Gap(10),
                                        AppTextField(enabled: !khoa, readOnly: true, controller: txtTenKH).expanded(),
                                      ],
                                    ),
                                    Row(children: [Gap(30), Text('Số hóa đơn').medium]),
                                    AppTextField(enabled: !khoa, controller: txtSoHD, onFieldLeave: () async {}),
                                  ],
                                ),
                                AppRow(
                                  columnWidths: {0: 80, 1: 690, 2: 150},
                                  items: [
                                    Text('Diễn giải').medium,
                                    AppTextField(enabled: !khoa, onFieldLeave: () async {}, controller: txtDienGiai),
                                    Row(children: [Gap(30), Text('Ngày hóa đơn').medium]),
                                    AppDateField(
                                      enabled: !khoa,

                                      value: ngayHoaDon,
                                      onChanged: (val) async {
                                        ngayHoaDon = val;
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          OutlinedContainer(
                            borderColor: AppColor.border300,
                            height: 200,
                            child: Padding(
                              padding: EdgeInsetsGeometry.all(10),
                              child: Column(
                                spacing: 5,
                                children: [
                                  Row(
                                    children: [
                                      OutlineButton(
                                        leading: Icon(PhosphorIcons.plus, size: 15),
                                        onPressed: () {
                                          _tableManager.addRow();
                                        },
                                        enabled: !khoa,
                                        size: ButtonSize(.8),
                                        child: Text("Thêm dòng"),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: PhieuXuatCTTable(
                                      khoa: khoa,
                                      onLoaded: (re) {
                                        _tableManager = PhieuXuatCTTableManager(re.stateManager);
                                        _tableManager.loadView(val.phieuXuatCT);
                                      },
                                      changedThanhTien: () {
                                        tongTienHang = NumHelper.numFormat(_tableManager.tongTienHang());

                                        if (thueSuat != null) {
                                          final x = (thueSuat! / 100) * NumHelper.stringToDouble(tongTienHang);
                                          tienThue = NumHelper.numFormat(x);
                                        }
                                        tongThanhToan = NumHelper.numFormat(
                                          _tableManager.tongTienHang() + NumHelper.stringToDouble(tienThue),
                                        );
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          setState(() {});
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          OutlinedContainer(
                            borderColor: AppColor.border300,
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    spacing: 10,
                                    children: [
                                      AppRow(
                                        columnWidths: {0: 80, 1: 100, 2: 100, 3: 80, 4: 140},
                                        items: [
                                          Text('TK Nợ/Có').medium,
                                          TaiKhoanXL0Combobox(
                                            enabled: !khoa,
                                            selected: tkNo,
                                            onChanged: (val) {
                                              setState(() {
                                                tkNo = val;
                                              });
                                            },
                                          ),
                                          TaiKhoanXL0Combobox(
                                            enabled: !khoa,
                                            selected: tkCo,
                                            onChanged: (val) {
                                              setState(() {
                                                tkCo = val;
                                              });
                                            },
                                          ),
                                          Row(children: [Gap(10), Text('Thuế suất').medium]),
                                          ThueSuatCombobox(
                                            enabled: !khoa,
                                            selected: thueSuat,
                                            onChanged: (val) {
                                              if (val != null) {
                                                final x = (val / 100) * NumHelper.stringToDouble(tongTienHang);
                                                tienThue = NumHelper.numFormat(x);
                                                tongThanhToan = NumHelper.numFormat(
                                                  x + NumHelper.stringToDouble(tongTienHang),
                                                );
                                              } else {
                                                tienThue = '0';
                                                tongThanhToan = tongTienHang;
                                              }

                                              setState(() {
                                                thueSuat = val;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      if (thueSuat != null)
                                        AppRow(
                                          columnWidths: {0: 80, 1: 100, 2: 100, 3: 80, 4: 140},
                                          items: [
                                            Text('TK VAT').medium,
                                            TaiKhoanXL0Combobox(
                                              enabled: !khoa,
                                              selected: tkVatNo,
                                              onChanged: (val) {
                                                setState(() {
                                                  tkVatNo = val;
                                                });
                                              },
                                            ),
                                            TaiKhoanXL0Combobox(
                                              enabled: !khoa,
                                              selected: tkVatCo,
                                              onChanged: (val) {
                                                setState(() {
                                                  tkVatCo = val;
                                                });
                                              },
                                            ),
                                            SizedBox(),
                                            SizedBox(),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(color: Colors.blue.shade100),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            // Icon(PhosphorIcons.moneyWavy,color: Colors.blue.shade700,),
                                            Text(
                                              'Tổng tiền thanh toán'.toUpperCase(),
                                              style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Gap(5),
                                        Row(
                                          children: [
                                            Text('Tổng tiền hàng'),
                                            Spacer(),
                                            Text(tongTienHang, style: TextStyle(fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('Thuế VAT'),
                                            Spacer(),
                                            Text(tienThue, style: TextStyle(fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                        Divider(color: AppColor.border300, height: 15),
                                        Row(
                                          children: [
                                            Text('Tổng cộng', style: TextStyle(fontWeight: FontWeight.w500)),
                                            Spacer(),
                                            Text(
                                              tongThanhToan,
                                              style: TextStyle(
                                                color: Colors.blue.shade700,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              error: (e, s) => Center(child: Text(e.toString())),
              loading: () => Center(child: CircularProgressIndicator(size: 50)),
            ),
          ),
        ),
      ),
    );
  }
}

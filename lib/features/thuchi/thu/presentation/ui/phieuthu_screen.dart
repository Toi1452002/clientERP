import 'package:collection/collection.dart';
import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/ui/state/khach_lookup_state.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/ui/widget/khach_combobox.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/presentation/ui/widget/nvu_thu_combobox.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/ui/widget/taikhoan_xl0_combobox.dart';
import 'package:erp_client_1/features/thuchi/thu/data/model/phieuthu_save_model.dart';
import 'package:erp_client_1/features/thuchi/thu/presentation/notifier/thu_delete_notifier.dart';
import 'package:erp_client_1/features/thuchi/thu/presentation/notifier/thu_notifier.dart';
import 'package:erp_client_1/features/thuchi/thu/presentation/notifier/thu_save_notifier.dart';
import 'package:erp_client_1/features/thuchi/thu/presentation/notifier/thu_update_edit_notifier.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/num_helper.dart';
import '../../../../../core/widgets/widget.dart';
import '../../../../danhmuc/khach/data/model/khach_lookup_model.dart';
import '../../data/model/phieuthu_model.dart';

class PhieuThuScreen extends ConsumerStatefulWidget {
  final String? phieu;
  const PhieuThuScreen({super.key, this.phieu});

  @override
  ConsumerState createState() => _PhieuThuScreenState();
}

class _PhieuThuScreenState extends ConsumerState<PhieuThuScreen> {
  DateTime ngay = DateTime.now();
  String pttt = "TM";
  String? maTC;
  String? maKH;
  String? tkNo;
  String? tkCo;
  bool khoa = false;
  final txtSoPhieu = TextEditingController();
  final txtTenKH = TextEditingController();
  final txtDiaChi = TextEditingController();
  final txtNguoiNop = TextEditingController();
  final txtNguoiThu = TextEditingController();
  final txtSoTien = TextEditingController();
  final txtLyDo = TextEditingController();
  final txtSoCT = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.phieu != null) {
        ref.read(thuProvider.notifier).getByPhieu(widget.phieu!);
      } else {
        ref.read(thuProvider.notifier).rebuild();
      }
    });


    ref.listenManual(thuProvider, (pre, next) {
      next.whenOrNull(
        data: (val) {
          setValue(val);
        },
      );
    });

    ref.listenManual(thuSaveProvider, (pre, next) {
      next.whenOrNull(
        data: (val) {
          saveSuccess();
        },
        error: (e, s) {
          showInfo(context, e.toString());
        },
      );
    });

    ref.listenManual(thuUpdateEditProvider, (pre, next) {
      next.whenOrNull(
        data: (val) {
          ref.read(thuProvider.notifier).updateEdit();
        },
        error: (e, s) {
          showInfo(context, e.toString());
        },
      );
    });

    ref.listenManual(thuDeleteProvider, (pre, next) {
      next.whenOrNull(
        data: (val) {
          ref.read(thuProvider.notifier).getNext();
        },
        error: (e, s) {
          showInfo(context, e.toString());
        },
      );
    });
  }

  void setValue(PhieuThuModel? pt) {
    if (pt == null) {
      txtSoPhieu.clear();
      return;
    }
    ngay = pt.ngay;
    maTC = pt.maTC;
    maKH = pt.maKH;
    tkNo = pt.tkNo;
    tkCo = pt.tkCo;
    pttt = pt.pttt;
    khoa = pt.khoa;
    txtSoPhieu.text = pt.phieu;
    txtTenKH.text = pt.tenKH ?? "";
    txtDiaChi.text = pt.diaChi ?? "";
    txtNguoiNop.text = pt.nguoiNop ?? "";
    txtNguoiThu.text = pt.nguoiThu ?? "";
    txtSoTien.text = NumHelper.numFormat(pt.soTien);
    txtLyDo.text = pt.noiDung ?? "";
    txtSoCT.text = pt.soCT ?? "";

    setState(() {});
  }

  void saveSuccess() {
    setState(() {
      khoa = true;
    });
  }

  PhieuThuSaveModel _saveModel() {
    return PhieuThuSaveModel(
      ngay: ngay,
      pttt: pttt,
      soTien: NumHelper.stringToDouble(txtSoTien.text),
      diaChi: txtDiaChi.text,
      maKH: maKH,
      maTC: maTC,
      nguoiNop: txtNguoiNop.text,
      nguoiThu: txtNguoiThu.text,
      noiDung: txtLyDo.text,
      soCT: txtSoCT.text.isEmpty?null:txtSoCT.text,
      tenKH: txtTenKH.text,
      tkCo: tkCo,
      tkNo: tkNo,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(thuProvider);
    final saveState = ref.watch(thuSaveProvider);
    final editState = ref.watch(thuUpdateEditProvider);
    final deleteState = ref.watch(thuDeleteProvider);
    return DialogWindows(
      width: 550,
      beforeClose: () async {
        if (!khoa && txtSoPhieu.text.isNotEmpty) {
          showQuestion(
            context,
            onPressed: () {
              Navigator.pop(context);
            },
            text: "Chưa lưu phiếu, có chắc muốn đóng?",
          );
        } else {
          Navigator.pop(context);
        }
      },
      height: 440,
      title: 'PHIẾU THU',
      child: Scaffold(
        backgroundColor: AppColor.background,
        footers: [
          Divider(color: AppColor.border,),
          AppBar(
            // backgroundColor: Colors.gray.shade200,
            leading: [
              AppButtonPage(
                first: () {
                  ref.read(thuProvider.notifier).getFirst();
                },
                last: () {
                  ref.read(thuProvider.notifier).rebuild();
                },
                back: () {
                  ref.read(thuProvider.notifier).getPrevious();
                },
                next: () {
                  ref.read(thuProvider.notifier).getNext();
                },
              ),
            ],
            // trailing: [
            //   Text('Người tạo: ${state.value?.createdBy}')
            // ],
          ),
        ],
        headers: [
          AppBar(
            // height: 25,
            // backgroundColor: Colors.gray.shade200,
            leading: [
              AppNewButton(
                text: 'Thêm',
                onPressed: () {
                  ref.read(thuProvider.notifier).addPhieu();
                },
                enabled: khoa || state.value == null,
              ),
              Gap(5),
              AppSaveButton(
                enabled: !khoa && state.value != null,
                onPressed: () {
                  final data = state.value;
                  if (data != null) {
                    ref.read(thuSaveProvider.notifier).save(_saveModel(), data.id);
                  }
                },
              ),
              Gap(5),
              AppEditButton(
                enabled: khoa,
                onPressed: () {
                  final data = state.value;
                  if (data != null) {
                    ref.read(thuUpdateEditProvider.notifier).updateEdit(data.id);
                    // ref.read(thuProvider.notifier).updateEdit(data.id);
                  }
                },
              ),
              Gap(5),
              AppDeleteButton(
                enabled: !khoa && state.value != null,
                onPressed: () {
                  showQuestion(
                    context,
                    onPressed: () {
                      final data = state.value;
                      if (data != null) {
                        ref.read(thuDeleteProvider.notifier).delete(data.id);
                      }
                    },
                  );
                },
              ),
              Gap(5),
              AppPrintButton(enabled: khoa),
            ],
          ),
          Divider(color: AppColor.border,),

        ],
        child: state.when(
          data: (val) {
            if (val == null) return Center(child: Text('Chưa có phiếu thu'));
            return LoadingOverlay(
              isLoading: saveState.isLoading || editState.isLoading || deleteState.isLoading,
              child: Container(
                // margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  spacing: 10,
                  children: [
                    AppRow(
                      columnWidths: {0: 110, 2: 90},
                      items: [
                        Text('Ngày thu'),
                        AppDateField(
                          enabled: !khoa,
                          value: ngay,
                          onChanged: (val) {
                            // if(val!=null){
                            if (val != null) {
                              ngay = val;
                            }

                            // else{
                            //   showInfo(context, "Ngày không hợp lệ");
                            //   ngay = ngay;
                            // }
                            // }else{
                            // showInfo(context, "Ngày không hợp lệ");
                            // }
                          },
                          // onChanged: (val) async {
                          // _controller.ngayThu = val;
                          // await _controller.updateNgay(val!,user);
                          // },
                        ),
                        Row(children: [Gap(20), Text('Số phiếu')]),
                        AppTextField(
                          readOnly: true,
                          fontWeight: FontWeight.w500,
                          controller: txtSoPhieu,
                          enabled: !khoa,
                        ),
                      ],
                    ),
                    AppRow(
                      columnWidths: {0: 110, 2: 90},
                      items: [
                        Text('Kiểu thu'),
                        NvuThuCombobox(
                          enabled: !khoa,
                          selected: maTC,
                          onChanged: (val) {
                            setState(() {
                              maTC = val;
                            });
                          },
                        ),
                        Row(children: [Gap(20), Text('Mã khách')]),
                        KhachCombobox(
                          enabled: !khoa,
                          selected: maKH,
                          onChanged: (val) {
                            final k = ref
                                .read(khachLookupProvider(LoaiKH.Khach))
                                .value;
                            final tmp = k?.firstWhereOrNull((e) => e.maKH == val);
                            if (tmp != null) {
                              txtTenKH.text = tmp.tenKH;
                              txtDiaChi.text = tmp.diaChi;
                            } else {
                              txtTenKH.clear();
                              txtDiaChi.clear();
                            }
                            setState(() {
                              maKH = val;
                            });
                          },
                        ),
                      ],
                    ),

                    AppRow(
                      columnWidths: {0: 110},
                      items: [
                        Text('Tên khách'),
                        AppTextField(
                          enabled: !khoa,
                          controller: txtTenKH,
                          // onFieldLeave: () async {
                          // await _controller.updateTenKH(_controller.txtTenKH.text,user);
                          // },
                          // enabled: !_controller.khoa,
                        ),
                      ],
                    ),
                    AppRow(
                      columnWidths: {0: 110},
                      items: [
                        Text('Địa chỉ'),
                        AppTextField(
                          enabled: !khoa,
                          controller: txtDiaChi,
                          // onFieldLeave: () async {
                          //   await _controller.updateDiaChi(_controller.txtDiaChi.text,user);
                          // },
                          // enabled: !_controller.khoa,
                        ),
                      ],
                    ),
                    AppRow(
                      columnWidths: {0: 110},
                      items: [
                        Text('Người nộp tiền'),
                        AppTextField(
                          enabled: !khoa,
                          controller: txtNguoiNop,
                          // onFieldLeave: () async {
                          //   await _controller.updateNguoiNop(_controller.txtNguoiNop.text,user);
                          // },
                          // enabled: !_controller.khoa,
                        ),
                      ],
                    ),
                    AppRow(
                      columnWidths: {0: 110},
                      items: [
                        Text('Người thu tiền'),
                        AppTextField(controller: txtNguoiThu, enabled: !khoa),
                      ],
                    ),
                    AppRow(
                      columnWidths: {0: 110, 1: 120, 2: 50, 4: 50},
                      items: [
                        Text('Số tiền'),
                        AppTextField(
                          enabled: !khoa,
                          // enabled: !_controller.khoa,
                          isNumber: true,
                          textAlign: TextAlign.end,
                          controller: txtSoTien,
                          onFieldLeave: () async {
                            txtSoTien.text = NumHelper.numFormat(txtSoTien.text);
                            // await _controller.updateSoTien(_controller.txtSoTien.text,user);
                          },
                        ),
                        Row(children: [Gap(20), Text('Nợ')]),
                        TaiKhoanXL0Combobox(
                          enabled: !khoa,
                          selected: tkNo,
                          onChanged: (val) {
                            setState(() {
                              tkNo = val;
                            });
                          },
                        ),
                        Row(children: [Gap(20), Text('Có')]),
                        TaiKhoanXL0Combobox(
                          enabled: !khoa,
                          selected: tkCo,
                          onChanged: (val) {
                            setState(() {
                              tkCo = val;
                            });
                          },
                        ),
                      ],
                    ),
                    AppRow(
                      columnWidths: {0: 110},
                      items: [
                        Text('Lý do nộp'),
                        AppTextField(
                          enabled: !khoa,
                          controller: txtLyDo,
                          // onFieldLeave: () async {
                          //   await _controller.updateNoiDung(_controller.txtLyDo.text,user);
                          // },
                          // enabled: !_controller.khoa,
                        ),
                      ],
                    ),
                    AppRow(
                      columnWidths: {0: 110, 2: 90},
                      items: [
                        Text('Số chứng từ'),
                        AppTextField(
                          enabled: !khoa,
                          controller: txtSoCT,
                          // onFieldLeave: () async {
                          //   await _controller.updateSoCT(_controller.txtSoCT.text,user);
                          // },
                          // enabled: !_controller.khoa,
                        ),
                        Row(children: [Gap(20), Text('PTTT')]),
                        AppCombobox(
                          // enabled: !_controller.khoa,
                          enabledClear: false,
                          value: pttt,
                          enabled: !khoa,
                          onChanged: (val) async {
                            // await _controller.updatePTTT(val,user);
                            setState(() {
                              pttt = val;
                            });
                          },
                          items: [
                            ComboboxItem(value: 'TM', text: ["Tiền mặt"]),
                            ComboboxItem(value: 'CK', text: ["Chuyển khoản"]),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          error: (e, s) => Center(child: Text(e.toString())),
          loading: () => Center(child: CircularProgressIndicator(size: 50)),
        ),
      ),
    );
  }
}

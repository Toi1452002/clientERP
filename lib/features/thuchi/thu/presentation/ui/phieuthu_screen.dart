import 'package:collection/collection.dart';
import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/shortcut/shortcut_config.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/ui/state/khach_lookup_state.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/ui/widget/khach_combobox.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/presentation/ui/widget/nvu_thu_combobox.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/ui/widget/taikhoan_xl0_combobox.dart';
import 'package:erp_client_1/features/report/presentation/notifier/report_notifier.dart';
import 'package:erp_client_1/features/thuchi/thu/data/model/phieuthu_save_model.dart';
import 'package:erp_client_1/features/thuchi/thu/presentation/notifier/thu_delete_notifier.dart';
import 'package:erp_client_1/features/thuchi/thu/presentation/notifier/thu_notifier.dart';
import 'package:erp_client_1/features/thuchi/thu/presentation/notifier/thu_save_notifier.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shortcut/Shortcut_intent.dart';
import '../../../../../core/utils/num_helper.dart';
import '../../../../../core/widgets/widget.dart';
import '../../../../danhmuc/khach/data/model/khach_lookup_model.dart';
import '../../../../report/presentation/dialog/report_dialog.dart';
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
  int id = 0;
  final txtSoPhieu = TextEditingController();
  final txtTenKH = TextEditingController();
  final txtDiaChi = TextEditingController();
  final txtNguoiNop = TextEditingController();
  final txtNguoiThu = TextEditingController();
  final txtSoTien = TextEditingController();
  final txtLyDo = TextEditingController();
  final txtSoCT = TextEditingController();

  bool isSave = false;
  bool isUpdateKhoa = false;

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
    id = pt.id;
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
    if (isSave) {
      setState(() {
        khoa = true;
        isSave = false;
      });
    }

    if (isUpdateKhoa) {
      setState(() {
        khoa = !khoa;
        isUpdateKhoa = false;

      });
    }
  }

  void _autoSave() {
    if (!khoa) {
      ref.read(thuSaveProvider.notifier).save(_saveModel(), id);
    }
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
      soCT: txtSoCT.text.isEmpty ? null : txtSoCT.text,
      tenKH: txtTenKH.text,
      tkCo: tkCo,
      tkNo: tkNo,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(thuProvider);
    final saveState = ref.watch(thuSaveProvider);
    final deleteState = ref.watch(thuDeleteProvider);
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
                ref.read(thuSaveProvider.notifier).updateKhoa(id);
                isUpdateKhoa = true;
              }
              return null;
            },
          ),
          NewIntent: CallbackAction<NewIntent>(
            onInvoke: (NewIntent intent) {
              _autoSave();
              ref.read(thuProvider.notifier).addPhieu();
              return null;
            },
          ),
          DeleteIntent: CallbackAction<DeleteIntent>(
            onInvoke: (DeleteIntent intent) {
              if(!khoa && state.value != null){
                showQuestion(context,onPressed: (){
                  ref.read(thuDeleteProvider.notifier).delete(id);
                });
              }
              return null;
            },
          ),
        },
        child: DialogWindows(
          width: 550,
          beforeClose: () async {
            if (!khoa && txtSoPhieu.text.isNotEmpty) {
              showClosePhieu(
                context,
                onPressed: () {
                  ref.read(thuSaveProvider.notifier).save(_saveModel(), id);
                  Navigator.pop(context);
                },
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
              Divider(color: AppColor.border),
              AppBar(
                // backgroundColor: Colors.gray.shade200,
                leading: [
                  AppButtonPage(
                    first: () {
                      _autoSave();
                      ref.read(thuProvider.notifier).getFirst();
                    },
                    last: () {
                      _autoSave();
                      ref.read(thuProvider.notifier).rebuild();
                    },
                    back: () {
                      _autoSave();
                      ref.read(thuProvider.notifier).getPrevious();
                    },
                    next: () {
                      _autoSave();
                      ref.read(thuProvider.notifier).getNext();
                    },
                    firstText: state.hasValue ? "${state.value?.stt ?? '0'}" : '0',
                    secondText: state.hasValue ? "${state.value?.tongStt ?? '0'}" : '0',
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
                  Focus(
                    autofocus: true,
                    child: AppNewButton(

                      text: 'Phiếu mới',
                      onPressed: () {
                        _autoSave();
                        ref.read(thuProvider.notifier).addPhieu();
                      },
                      // enabled: khoa || state.value == null,
                    ),
                  ),
                  Gap(5),
                  AppSaveButton(
                    enabled: !khoa && state.value != null,
                    onPressed: () {
                      final data = state.value;
                      if (data != null) {
                        isSave = true;
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
                        ref.read(thuSaveProvider.notifier).updateKhoa(data.id);
                        isUpdateKhoa = true;

                        // ref.read(thuUpdateEditProvider.notifier).updateEdit(data.id);
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
                  AppPrintButton(enabled: khoa,onPressed: () async {
                    ref.read(reportProvider.notifier).getPhieuThu(id);
                    await showPrinter(context, ref);
                    // showDialog(context: context,fullScreen: true, builder: (context){
                    //   return ReportDialog();
                    // });

                  },),
                ],
              ),
              Divider(color: AppColor.border),
            ],
            child: state.when(
              data: (val) {
                if (val == null) {
                  return Center(
                    child: Text('Chưa có phiếu thu', style: TextStyle(color: Colors.gray)),
                  );
                }
                return AppLoadingOverlay(
                  isLoading: saveState.isLoading || deleteState.isLoading,
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
                            Text('Ngày thu').medium,
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
                                //   ngay = ngay    ;
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
                            Row(children: [Gap(20), Text('Số phiếu').medium]),
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
                            Text('Kiểu thu').medium,
                            NvuThuCombobox(
                              enabled: !khoa,
                              selected: maTC,
                              onChanged: (val) {
                                setState(() {
                                  maTC = val;
                                });
                              },
                            ),
                            Row(children: [Gap(20), Text('Mã khách').medium]),
                            KhachCombobox(
                              enabled: !khoa,
                              selected: maKH,
                              onChanged: (val) {
                                final k = ref.read(khachLookupProvider(LoaiKH.Khach)).value;
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
                            Text('Tên khách').medium,
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
                            Text('Địa chỉ').medium,
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
                            Text('Người nộp tiền').medium,
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
                            Text('Người thu tiền').medium,
                            AppTextField(controller: txtNguoiThu, enabled: !khoa),
                          ],
                        ),
                        AppRow(
                          columnWidths: {0: 110, 1: 120, 2: 50, 4: 50},
                          items: [
                            Text('Số tiền').medium,
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
                            Row(children: [Gap(20), Text('Nợ').medium]),
                            TaiKhoanXL0Combobox(
                              enabled: !khoa,
                              selected: tkNo,
                              onChanged: (val) {
                                setState(() {
                                  tkNo = val;
                                  if(tkNo=="1121"){
                                    pttt = "CK";
                                  }else if(tkNo == "1111"){
                                    pttt = "TM";
                                  }
                                });
                              },
                            ),
                            Row(children: [Gap(20), Text('Có').medium]),
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
                            Text('Lý do nộp').medium,
                            AppTextField(enabled: !khoa, controller: txtLyDo),
                          ],
                        ),
                        AppRow(
                          columnWidths: {0: 110, 2: 90},
                          items: [
                            Text('Số chứng từ').medium,
                            AppTextField(enabled: !khoa, controller: txtSoCT),
                            Row(children: [Gap(20), Text('PTTT').medium]),
                            AppCombobox(
                              // enabled: !_controller.khoa,
                              enabledClear: false,
                              value: pttt,
                              enabled: !khoa,
                              onChanged: (val) async {
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
        ),
      ),
    );
  }
}

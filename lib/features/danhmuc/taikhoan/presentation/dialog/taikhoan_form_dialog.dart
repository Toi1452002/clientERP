import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_alert.dart';
import 'package:erp_client_1/core/widgets/app_button.dart';
import 'package:erp_client_1/core/widgets/app_combobox.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/core/widgets/app_loading_overlay.dart';
import 'package:erp_client_1/core/widgets/app_row.dart';
import 'package:erp_client_1/core/widgets/app_textfield.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/data/model/taikhoan_request_model.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/data/model/taikhoan_view_model.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/notifier/taikhoan_edit_notifier.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/notifier/taikhoan_save_notifier.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/notifier/taikhoan_view_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TaiKhoanFormDialog extends ConsumerStatefulWidget {
  final int? id;

  const TaiKhoanFormDialog({super.key, this.id});

  @override
  ConsumerState createState() => _TaiKhoanFormDialogState();
}

class _TaiKhoanFormDialogState extends ConsumerState<TaiKhoanFormDialog> {
  List<String> lstTinhChat = ['N', 'C', 'L'];
  List<int> lstMaXL = [0, 1];

  final txtMaTK = TextEditingController();
  final txtTenTK = TextEditingController();
  final txtGhiChu = TextEditingController();
  String? tinhChat;
  int maXL = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(taiKhoanEditProvider.notifier).get(id: widget.id);
    });

    ref.listenManual(taiKhoanEditProvider, (pre, next) {
      next.whenOrNull(
        data: (val) {
          if (val != null) {
            setValue(val);
          }
        },
        error: (e, s) {
          showInfo(context, e.toString());
        },
      );
    });

    ref.listenManual(taiKhoanSaveProvider, (pre, next) {
      next.whenOrNull(
        data: (val) {
          if(val!=null){
            if(widget.id==null){
              ref.read(taiKhoanViewProvider.notifier).add(val);
            }else{
              ref.read(taiKhoanViewProvider.notifier).updateRow(val);
            }
          }
          Navigator.pop(context);
        },
      );
    });
  }

  TaiKhoanRequestModel _model() {
    return TaiKhoanRequestModel(
      maTK: txtMaTK.text,
      tenTK: txtTenTK.text,
      maXL: maXL,
      ghiChu: txtGhiChu.text,
      tinhChat: tinhChat,
    );
  }

  void setValue(TaiKhoanViewModel model) {
    txtMaTK.text = model.maTK;
    txtTenTK.text = model.tenTK;
    tinhChat = model.tinhChat;
    maXL = model.maXL;
    txtGhiChu.text = model.ghiChu ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final getEditState = ref.watch(taiKhoanEditProvider);
    final state = ref.watch(taiKhoanSaveProvider);
    return DialogWindows(
      width: 450,
      height: 200,
      title: "THÔNG TIN TÀI KHOẢN KẾ TOÁN",
      child: AppLoadingOverlay(
        isLoading: getEditState.isLoading || state.isLoading,
        child: Scaffold(
          footers: [
            Divider(color: AppColor.border300),
            AppBar(
              leading: [if (state.hasError) Text(state.error.toString(), style: TextStyle(color: Colors.red))],
              trailing: [
                AppSaveButton(
                  onPressed: () {
                    if (widget.id == null) {
                      ref.read(taiKhoanSaveProvider.notifier).add(_model());
                    } else {
                      ref.read(taiKhoanSaveProvider.notifier).updateTK(_model(), widget.id!);
                    }
                  },
                ),
              ],
            ),
          ],
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              spacing: 10,
              children: [
                AppRow(
                  columnWidths: {0: 60, 1: 70, 2: 80, 4: 60},
                  items: [
                    Text('Mã TK').medium,
                    AppTextField(maxLength: 6, isNumber: true, controller: txtMaTK),
                    Row(children: [Gap(10), Text('Tính chất').medium]),
                    AppCombobox(
                      value: tinhChat,
                      enabledClear: true,
                      onChanged: (val) {
                        setState(() {
                          tinhChat = val;
                        });
                      },
                      items: lstTinhChat.map((e) => ComboboxItem(value: e, text: [e])).toList(),
                    ),
                    Row(children: [Gap(10), Text('Mã XL').medium]),
                    AppCombobox(
                      enabledClear: false,
                      value: maXL,
                      onChanged: (val) {
                        setState(() {
                          maXL = val;
                        });
                      },
                      items: lstMaXL.map((e) => ComboboxItem(value: e, text: [e.toString()])).toList(),
                    ),
                  ],
                ),
                AppRow(
                  columnWidths: {0: 60},
                  items: [
                    Text('Mô tả').medium,
                    AppTextField(controller: txtTenTK),
                  ],
                ),
                AppRow(
                  columnWidths: {0: 60},
                  items: [
                    Text('Ghi chú').medium,
                    AppTextField(controller: txtGhiChu),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

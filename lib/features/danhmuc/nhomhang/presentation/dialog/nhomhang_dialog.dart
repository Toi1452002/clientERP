import 'package:erp_client_1/core/widgets/app_header.dart';
import 'package:erp_client_1/features/danhmuc/nhomhang/presentation/notifier/nhomhang_edit_notifier.dart';
import 'package:erp_client_1/features/danhmuc/nhomhang/presentation/notifier/nhomhang_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../../core/widgets/app_alert.dart';
import '../../../../../../core/widgets/app_button.dart';
import '../../../../../../core/widgets/app_dialog.dart';
import '../../../../../../core/widgets/app_row.dart';
import '../../../../../../core/widgets/app_textfield.dart';
import '../../../../../core/constain/app_color.dart';
import '../ui/widget/nhomhang_table.dart';


class NhomHangDialog extends ConsumerStatefulWidget {
  const NhomHangDialog({super.key});

  @override
  ConsumerState createState() => _NhomHangDialogState();
}

class _NhomHangDialogState extends ConsumerState<NhomHangDialog> {
  final txtNhomHang = TextEditingController();

  void onSubmit(String dvt)  {
    ref.read(nhomHangEditProvider.notifier).add(dvt);
    txtNhomHang.clear();
  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(nhomHangEditProvider);
    return DialogWindows(
      width: 330,
      height: 500,
      title: "DANH SÁCH NHÓM HÀNG",
      child: Scaffold(
        backgroundColor: AppColor.background,
        footers: [
          AppFooter(
            leading: [
              if(state.hasError) Text(state.error.toString(),style: TextStyle(color: Colors.red),)
            ],
          )
        ],
        child: Scaffold(headers: [
          Container(
            decoration: BoxDecoration(border: Border.all(color: AppColor.border)),
            padding: EdgeInsets.all(5),
            child: AppRow(
              columnWidths: {1: 30},
              items: [
                AppTextField(
                  hintText: 'Nhập nhóm hàng',
                  controller: txtNhomHang,
                  onSubmitted: onSubmit,
                ),
                AppAddButton(onPressed: ()  =>  onSubmit(txtNhomHang.text.trim())),
              ],
            ),
          )
        ],child: NhomHangTable()),
      ),
    );
  }
}

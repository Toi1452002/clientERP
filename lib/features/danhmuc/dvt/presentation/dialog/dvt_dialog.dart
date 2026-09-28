import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/features/danhmuc/dvt/presentation/notifier/dvt_edit_notifier.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/widget.dart';
import '../ui/widget/dvt_table.dart';

class DvtDialog extends ConsumerStatefulWidget {
  const DvtDialog({super.key});

  @override
  DonViTinhScreenState createState() => DonViTinhScreenState();
}

class DonViTinhScreenState extends ConsumerState<DvtDialog> {
  final txtDVT = TextEditingController();

  void onSubmit(String dvt)  {
    ref.read(dvtEditProvider.notifier).add(dvt);
    txtDVT.clear();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dvtEditProvider);
    return DialogWindows(
      width: 330,
      height: 500,
      title: "DANH SÁCH ĐƠN VỊ TÍNH",
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
            child:  AppRow(
              columnWidths: {1: 30},
              items: [
                AppTextField(
                  hintText: 'Nhập đơn vị tính',
                  controller: txtDVT,
                  onSubmitted: onSubmit,
                ),
                AppAddButton(onPressed: ()  =>  onSubmit(txtDVT.text.trim())),
              ],
            ),
          )
        ],child: DvtTable()),
      ),
    );
  }
}

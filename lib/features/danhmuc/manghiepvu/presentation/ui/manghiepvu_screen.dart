import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/data/model/manghiepvu_request_model.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/presentation/notifier/manghiepvu_edit_notifier.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/presentation/notifier/manghiepvu_notifier.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/presentation/ui/state/manghiepvu_table_manager.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/widget.dart';
import 'widget/manghiepvu_table.dart';

class MaNghiepVuScreen extends ConsumerStatefulWidget {
  const MaNghiepVuScreen({super.key});

  @override
  ConsumerState createState() => _MaNghiepVuScreenState();
}

class _MaNghiepVuScreenState extends ConsumerState<MaNghiepVuScreen> {
  final txtMa = TextEditingController();
  final txtMoTa = TextEditingController();

  MaNghiepVuRequestModel _model() => MaNghiepVuRequestModel(maNV: txtMa.text, moTa: txtMoTa.text);

  // Future<void> onSubmit() async {
  //   try {
  //     await ref.read(maNghiepVuProvider.notifier).add(_model());
  //
  //   } catch (e) {
  //     if(context.mounted) showInfo(context, e.toString());
  //   }
  // }
  void onSubmit() {
    ref.read(maNghiepVuEditProvider.notifier).add(_model());
    txtMa.clear();
    txtMoTa.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final editState = ref.watch(maNghiepVuEditProvider);
    return DialogWindows(
      width: 440,
      height: 500,
      title: 'Danh sách mã nghiệp vụ',
      child: Scaffold(
        footers: [
          AppFooter(
            leading: [if (editState.hasError) Text(editState.error.toString(), style: TextStyle(color: Colors.red))],
          ),
        ],
        headers: [
          Container(
            decoration: BoxDecoration(border: Border.all(color: AppColor.border)),
            padding: EdgeInsets.all(5),
            child: AppRow(
              columnWidths: {0: 100, 2: 40},
              items: [
                AppTextField(hintText: 'Nhập mã', controller: txtMa),
                AppTextField(
                  hintText: 'Nhập mô tả',
                  controller: txtMoTa,
                  onSubmitted: (val) {
                    onSubmit();
                  },
                ),
                AppAddButton(
                  onPressed: () {
                    onSubmit();
                  },
                ),
              ],
            ),
          ),
        ],
        child: ManNghiepVuTable(),
      ),
    );
  }
}

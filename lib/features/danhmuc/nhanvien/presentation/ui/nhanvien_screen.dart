import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/core/widgets/app_header.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/dialog/nhanvien_form_dialog.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/notifier/nhanvien_view_notifier.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/notifier/pcgt_view_notifier.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/ui/state/nhanvien_lookup_state.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/ui/widget/nhanvien_table.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constain/app_color.dart';
import '../../../../../core/widgets/app_button.dart';

class NhanVienScreen extends ConsumerWidget {
  const NhanVienScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColor.background,
      headers: [
        AppHeader(
          title: "Danh sách nhân viên",
          trailing: [
            AppReloadButton(
              onPressed: () {
                ref.refresh(nhanVienViewProvider);
                ref.invalidate(nhanVienLookupProvider);
                // ref.refresh(khachViewProvider);
              },
            ),
            Gap(10),
          ],
        ),
        AppBar(
          leading: [
            AppNewButton(
              text: 'Thêm nhân viên',
              onPressed: () {
                ref.read(pcgtViewProvider.notifier).getView();
                showAppDialog(context, child: NhanVienFormDialog());
                // showAppDialog(context, child: KhachFormDialog());
              },
            ),
            Gap(5),
          ],
        ),
        Divider(color: AppColor.border300,)
      ],
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        child: NhanVienTable(),
      ),
    );
  }
}

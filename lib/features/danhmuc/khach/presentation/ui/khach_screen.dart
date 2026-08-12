import 'package:erp_client_1/features/danhmuc/khach/presentation/dialog/khach_form_dialog.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/notifier/khach_view_notifier.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/ui/widget/khach_table.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constain/app_color.dart';
import '../../../../../core/widgets/widget.dart';

class KhachScreen extends ConsumerWidget {
  const KhachScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColor.background,
      headers: [
        AppHeader(
          title: "Danh sách khách hàng – nhà cung",
          trailing: [
            AppReloadButton(
              onPressed: () {
                ref.refresh(khachViewProvider);
                // ref.refresh(userViewProvider);
              },
            ),
            Gap(10),
          ],
        ),
        AppBar(
          // padding: EdgeInsets.only(left: 20, top: 10, bottom: 5),
          leading: [
            AppNewButton(
              text: 'Thêm khách',
              onPressed: () {
                showAppDialog(context, child: KhachFormDialog());
              },
            ),
            Gap(5),
          ],
        ),
        Divider(color: AppColor.border300,)
      ],
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        child: KhachTable(),
      ),
    );
  }
}

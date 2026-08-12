import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/core/widgets/app_header.dart';
import 'package:erp_client_1/features/danhmuc/dvt/presentation/notifier/dvt_notifier.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/presentation/dialog/hanghoa_form_dialog.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/presentation/notifier/hanghoa_edit_notifier.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/presentation/ui/state/hanghoa_lookup_provider.dart';
import 'package:erp_client_1/features/danhmuc/nhomhang/presentation/notifier/nhomhang_notifier.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/app_button.dart';
import '../notifier/hanghoa_view_notifierr.dart';
import 'widget/hanghoa_table.dart';

class HangHoaScreen extends ConsumerWidget {
  const HangHoaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColor.background,
      headers: [
        AppHeader(title: "Danh sách hàng hóa – vật tư",trailing: [
          AppReloadButton(
            onPressed: () {
              ref.refresh(hangHoaViewProvider);
              ref.refresh(dvtProvider);
              ref.refresh(nhomhangProvider);
              ref.refresh(loaiHangProvider);
              ref.invalidate(hangHoaLookupProvider);
            },
          ),
          Gap(10),
        ],),
        AppBar(
          // padding: EdgeInsets.only(left: 10, top: 10, bottom: 5),
          leading: [
            AppNewButton(
              text: 'Thêm hàng hóa',
              onPressed: () {
                showAppDialog(context, child: HangHoaFormDialog());
                // context.goNamed(hangHoaAdd);
                // context.goNamed(khachAdd);
              },
            ),
            // AppPrintButton(
            //   onPressed: () {
            //     context.goNamed(hangHoaPrint);
            //     // context.goNamed(khachAdd);
            //   },
            // ),
          ],
        ),
        Divider(color: AppColor.border300,)
      ],
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: HangHoaTable(),
      ),
    );
  }
}

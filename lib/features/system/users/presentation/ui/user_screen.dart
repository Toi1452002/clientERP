import 'package:erp_client_1/features/system/auth/presentation/notifier/auth_notifier.dart';
import 'package:erp_client_1/features/system/users/presentation/dialog/user_form.dart';
import 'package:erp_client_1/features/system/users/presentation/notifier/user_change_info_notifier.dart';
import 'package:erp_client_1/features/system/users/presentation/notifier/user_view_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../core/constain/app_color.dart';
import '../../../../../core/widgets/widget.dart';
import 'widget/user_table.dart';

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({super.key});

  @override
  ConsumerState createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.background,
      footers: [AppFooter()],
      headers: [
        // AppHeader(
        //   title: "Danh sách người dùng",
        // ),
        AppBar(
          leading: [
            AppNewButton(
              text: 'Thêm người dùng',
              onPressed: () {
                showAppDialog(context, child: UserForm());
              },
            ),
          ],
        ),
        Divider(color: AppColor.border300),
      ],
      child: UserTable(),
    );
  }
}

import 'package:erp_client_1/features/system/users/presentation/dialog/user_form.dart';
import 'package:erp_client_1/features/system/users/presentation/notifier/user_view_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
      backgroundColor: AppColor.background,
      footers: [AppFooter()],
      headers: [
        AppHeader(title: "Danh sách người dùng",trailing: [ AppReloadButton(
          onPressed: () {
            ref.refresh(userViewProvider);
          },
        ),
          Gap(10),],),
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
        Divider(color: AppColor.border300,)
      ],
      child: UserTable(),
    );
  }
}

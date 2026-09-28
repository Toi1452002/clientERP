import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/features/system/users/presentation/notifier/user_edit_notifier.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/widgets/widget.dart';

class UserChangePassword extends ConsumerStatefulWidget {
  final int id;
  final String username;

  const UserChangePassword({super.key, required this.id, required this.username});

  @override
  UserChangePasswordState createState() => UserChangePasswordState();
}

class UserChangePasswordState extends ConsumerState<UserChangePassword> {
  final txtPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.listenManual(userEditProvider, (pre, next) {
      next.whenOrNull(
        data: (_) {
          Navigator.pop(context);
          showInfo(context, "Thay đổi mật khẩu thành công");
        },
        // error: (e, s) {
        //   showError(context, e.toString());
        // },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userEditProvider);
    return DialogWindows(
      width: 350,
      height: 160,
      title: "Thay đổi mật khẩu",
      child: AppLoadingOverlay(
        isLoading: state.isLoading,
        child: Scaffold(
          footers: [
            Divider(color: AppColor.border300,),
            AppBar(
              leading: [
                if(state.hasError) Text(state.error.toString(),style: TextStyle(color: Colors.red),)
              ],
              trailing: [
                AppSaveButton(
                  onPressed: () {
                    ref.read(userEditProvider.notifier).updatePassword(txtPassword.text.trim(), widget.id);
                  },
                ),
              ],
            )
          ],
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppRow(
                  columnWidths: {0: 70},
                  items: [
                    Text('Username').medium,
                    AppTextField(
                      controller: TextEditingController(text: widget.username),
                      enabled: false,
                    ),
                  ],
                ),
                AppRow(
                  columnWidths: {0: 70},
                  items: [
                    Text('Password').medium,
                    AppTextField(controller: txtPassword, obscureText: true, autofocus: true),

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

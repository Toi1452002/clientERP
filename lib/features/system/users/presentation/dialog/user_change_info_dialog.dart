import 'package:erp_client_1/core/widgets/app_button.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/core/widgets/app_row.dart';
import 'package:erp_client_1/core/widgets/app_textfield.dart';
import 'package:erp_client_1/features/system/users/data/model/user_changed_info_model.dart';
import 'package:erp_client_1/features/system/users/presentation/notifier/user_change_info_notifier.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constain/app_color.dart';
import '../../../../../core/widgets/app_alert.dart';
import '../../../auth/presentation/notifier/auth_notifier.dart';

class UserChangeInfoDialog extends ConsumerStatefulWidget {
  const UserChangeInfoDialog({super.key});

  @override
  ConsumerState createState() => _UserChangeInfoDialogState();
}

class _UserChangeInfoDialogState extends ConsumerState<UserChangeInfoDialog> {
  final txtOldUsername = TextEditingController();
  final txtOldPassword = TextEditingController();
  final txtNewUsername = TextEditingController();
  final txtNewPassword = TextEditingController();
  final txtConfirmPassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.listenManual(userChangedInfoProvider, (_,next){
      next.whenOrNull(data: (val){
        if(val!=0){
          showSuccess(context, "Đổi tài khoản thành công, vui lòng đăng nhập lại", (){
            ref.read(authNotifierProvider.notifier).logout();
          });
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userChangedInfoProvider);
    return DialogWindows(
      width: 400,
      height: 270,
      title: 'Thay đổi tài khoản người dùng',
      child: LoadingOverlay(
        isLoading: state.isLoading,
        child: Scaffold(
          footers: [
            Divider(color: AppColor.border300,),
            AppBar(
              leading: [if (state.hasError) Text(state.error.toString(), style: TextStyle(color: Colors.red))],
              trailing: [

                AppSaveButton(
                  onPressed: () {
                    ref
                        .read(userChangedInfoProvider.notifier)
                        .changed(
                          UserChangedInfoModel(
                            confirmPassword: txtConfirmPassword.text,
                            newPassword: txtNewPassword.text,
                            newUsername: txtNewUsername.text,
                            oldPassword: txtOldPassword.text,
                            oldUsername: txtOldUsername.text,
                          ),
                        );
                  },
                  text: "Chấp nhận",
                ),
              ],
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              spacing: 10,
              children: [
                AppRow(
                  columnWidths: {0: 150},
                  items: [
                    Text('Tên đăng nhập cũ').medium,
                    AppTextField(controller: txtOldUsername),
            
                  ],
                ),
                AppRow(
                  columnWidths: {0: 150},
                  items: [
                    Text('Mật khẩu cũ').medium,
                    AppTextField(obscureText: true, controller: txtOldPassword),
                  ],
                ),
                Divider(),
                AppRow(
                  columnWidths: {0: 150},
                  items: [
                    Text('Tên đăng nhập mới').medium,
                    AppTextField(controller: txtNewUsername),
                  ],
                ),
                AppRow(
                  columnWidths: {0: 150},
                  items: [
                    Text('Mật khẩu mới').medium,
                    AppTextField(obscureText: true, controller: txtNewPassword),
                  ],
                ),
                AppRow(
                  columnWidths: {0: 150},
                  items: [
                    Text('Nhập lại mật khẩu').medium,
                    AppTextField(obscureText: true, controller: txtConfirmPassword),
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

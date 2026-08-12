import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/features/system/roles/presentation/ui/widget/role_combobox.dart';
import 'package:erp_client_1/features/system/users/data/model/user_add_model.dart';
import 'package:erp_client_1/features/system/users/data/model/user_update_model.dart';
import 'package:erp_client_1/features/system/users/presentation/notifier/user_edit_notifier.dart';
import 'package:erp_client_1/features/system/users/presentation/notifier/user_view_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../../../../../core/widgets/widget.dart';

class UserForm extends ConsumerStatefulWidget {
  final int? id;

  const UserForm({super.key, this.id});

  @override
  ConsumerState createState() => _UserFormState();
}

class _UserFormState extends ConsumerState<UserForm> {
  final txtFullName = TextEditingController();
  final txtPhone = TextEditingController();
  final txtAddress = TextEditingController();
  final txtEmail = TextEditingController();
  final txtNote = TextEditingController();
  final txtUsername = TextEditingController();
  final txtPassword = TextEditingController();
  int selectRoleID = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.id!=null){
      loadUser(widget.id!);
    }
    ref.listenManual(userEditProvider, (pre, next) {
      next.whenOrNull(
        data: (val) {
          ref.invalidate(userViewProvider);
          context.pop();
        },
        error: (e, s) {
          showInfo(context, e.toString());
        },
      );
    });
  }

  Future<void> loadUser(int id) async {
    try {
      final user = await ref.read(userEditProvider.notifier).loadUser(id);
      if (user == null) return;
      txtUsername.text = user.username;
      txtFullName.text = user.fullName;
      txtPhone.text = user.phone ?? '';
      txtNote.text = user.note ?? '';
      txtEmail.text = user.email ?? '';
      txtAddress.text = user.address ?? '';
      selectRoleID = user.roleId;
      setState(() {});
    } catch (e) {
      if (context.mounted) showError(context, e.toString());
    }
  }

  UserUpdateModel _userUpdateModel() => UserUpdateModel(
    username: txtUsername.text.trim(),
    fullName: txtFullName.text.trim(),
    roleId: selectRoleID,
    email: txtEmail.text.trim(),
    address: txtAddress.text.trim(),
    note: txtNote.text.trim(),
    phone: txtPhone.text.trim(),
  );

  UserAddModel _userAddModel() => UserAddModel(
    username: txtUsername.text.trim(),
    password: txtPassword.text.trim(),
    fullName: txtFullName.text.trim(),
    roleId: selectRoleID,
    email: txtEmail.text.trim(),
    address: txtAddress.text.trim(),
    note: txtNote.text.trim(),
    phone: txtPhone.text.trim(),
  );

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userEditProvider);
    return DialogWindows(
      width: 500,
      height: 420,
      title: 'Thông tin người dùng',
      child: LoadingOverlay(
        isLoading: state.isLoading,
        child: Scaffold(
          backgroundColor: AppColor.background,
          footers: [
            Divider(color: AppColor.border300,),
            AppBar(
              trailing: [
                AppSaveButton(
                  onPressed: () {
                    if (widget.id == null) {
                      ref.read(userEditProvider.notifier).add(_userAddModel());
                    } else {
                      ref.read(userEditProvider.notifier).updateUser(_userUpdateModel(), widget.id!);
                    }
                  },
                )
              ],
            )
          ],
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: [
                  OutlinedContainer(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      spacing: 10,
                      children: [
                        AppRow(
                          columnWidths: {0: 100},
                          items: [
                            Text('Họ và tên').medium,
                            AppTextField(controller: txtFullName),
                          ],
                        ),
                        AppRow(
                          columnWidths: {0: 100},
                          items: [
                            Text('Điện thoại').medium,
                            AppTextField(controller: txtPhone),
                          ],
                        ),
                        AppRow(
                          columnWidths: {0: 100},
                          items: [
                            Text('Địa chỉ').medium,
                            AppTextField(controller: txtAddress),
                          ],
                        ),
                        AppRow(
                          columnWidths: {0: 100},
                          items: [
                            Text('Email').medium,
                            AppTextField(controller: txtEmail),
                          ],
                        ),
                        AppRow(
                          columnWidths: {0: 100},
                          items: [
                            Text('Ghi chú').medium,
                            AppTextField(controller: txtNote, maxLines: 2),
                          ],
                        ),
                      ],
                    ),
                  ),
                  OutlinedContainer(
                    padding: EdgeInsets.all(10),

                    child: Column(
                      spacing: 10,
                      children: [
                        AppRow(
                          columnWidths: {0: 100},
                          items: [
                            Text('Username').medium,
                            AppTextField(controller: txtUsername),
                          ],
                        ),
                        AppRow(
                          columnWidths: {0: 100},
                          items: [
                            Text('Password').medium,
                            AppTextField(obscureText: true, controller: txtPassword, enabled: widget.id == null),
                          ],
                        ),
                        AppRow(
                          columnWidths: {0: 100},
                          items: [
                            Text('Vai trò').medium,
                            RoleCombobox(
                              selectId: selectRoleID,
                              onChanged: (val) {
                                setState(() {
                                  selectRoleID = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/features/system/roles/presentation/ui/widget/role_combobox.dart';
import 'package:erp_client_1/features/system/users/data/model/user_add_model.dart';
import 'package:erp_client_1/features/system/users/data/model/user_update_model.dart';
import 'package:erp_client_1/features/system/users/presentation/notifier/user_edit_notifier.dart';
import 'package:erp_client_1/features/system/users/presentation/notifier/user_get_edit_notifier.dart';
import 'package:erp_client_1/features/system/users/presentation/notifier/user_view_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../../../../../core/widgets/widget.dart';
import '../../data/model/user_edit_model.dart';

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

  bool themTiep = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userGetEditProvider.notifier).get(id: widget.id);
    });

    ref.listenManual(userGetEditProvider, (_, next) {
      next.whenOrNull(
        data: (val) {
          if (val != null) {
            loadUser(val);
          }
        },
        error: (e, s) {
          showInfo(context, e.toString());
        },
      );
    });

    ref.listenManual(userEditProvider, (pre, next) {
      next.whenOrNull(
        data: (val) {
          if (val != null) {
            if (widget.id == null) {
              ref.read(userViewProvider.notifier).add(val);
            } else {
              ref.read(userViewProvider.notifier).updateRow(val);
            }
            if (themTiep) {
              clear();
            } else {
              context.pop();
            }
          }
        },
      );
    });
  }

  Future<void> loadUser(UserEditModel user) async {
    txtUsername.text = user.username;
    txtFullName.text = user.fullName;
    txtPhone.text = user.phone ?? '';
    txtNote.text = user.note ?? '';

    txtEmail.text = user.email ?? '';
    txtAddress.text = user.address ?? '';
    selectRoleID = user.roleId;
    setState(() {});
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

  void clear() {
    txtUsername.clear();
    txtFullName.clear();
    txtPhone.clear();
    txtNote.clear();
    txtEmail.clear();
    txtAddress.clear();
    selectRoleID = 1;
    txtPassword.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userEditProvider);
    final getEditState = ref.watch(userGetEditProvider);
    return DialogWindows(
      width: 500,
      height: 420,
      title: 'Thông tin người dùng',
      child: AppLoadingOverlay(
        isLoading: state.isLoading || getEditState.isLoading,
        child: Scaffold(
          // backgroundColor: AppColor.background,
          footers: [
            Divider(color: AppColor.border300),
            AppBar(
              leading: [if (state.hasError) Text(state.error.toString(), style: TextStyle(color: Colors.red))],
              trailing: [
                AppSaveButton(
                  text: "Lưu & đóng",
                  onPressed: () {
                    themTiep = false;
                    if (widget.id == null) {
                      ref.read(userEditProvider.notifier).add(_userAddModel());
                    } else {
                      ref.read(userEditProvider.notifier).updateUser(_userUpdateModel(), widget.id!);
                    }
                  },
                ),
                AppSaveButton(
                  text: "Lưu",
                  onPressed: () {
                    themTiep = true;
                    ref.read(userEditProvider.notifier).add(_userAddModel());
                  },
                ),
              ],
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: [
                  Column(
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
                  Divider(),
                  Column(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

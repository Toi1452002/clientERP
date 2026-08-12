import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/features/system/roles/presentation/notifier/role_view_notifier.dart';
import 'package:erp_client_1/features/system/roles/presentation/ui/widget/role_table.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../core/widgets/widget.dart';

class RoleDialog extends ConsumerStatefulWidget {
  const RoleDialog({super.key});

  @override
  ConsumerState createState() => _RoleDialogState();
}

class _RoleDialogState extends ConsumerState<RoleDialog> {
  final txtVaiTro = TextEditingController();

  Future<void> onSubmit(String dvt) async {
    try {
      if (dvt.isEmpty) return;
      await ref.read(roleViewProvider.notifier).add(txtVaiTro.text);
      txtVaiTro.clear();
    } catch (e) {
      if (context.mounted) showInfo(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DialogWindows(
      width: 330,
      height: 500,
      title: "DANH SÁCH VAI TRÒ",
      child: Scaffold(
        backgroundColor: AppColor.background,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Scaffold(
            headers: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.border)
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  // columnWidths: {0:200,1: 30},
                  children: [
                    Expanded(
                      child: AppTextField(
                        hintText: 'Nhập vai trò',
                        controller: txtVaiTro,
                        onSubmitted: (val) async {
                          await onSubmit(val);
                        },
                      ),
                    ),
                    Gap(5),
                    AppAddButton(onPressed: () async => await onSubmit(txtVaiTro.text.trim())),
                  ],
                ),
              ),
            ],
            child: RoleTable(),
          ),
        ),
      ),
    );
  }
}

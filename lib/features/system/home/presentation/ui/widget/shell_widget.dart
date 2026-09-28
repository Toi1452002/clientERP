import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/router/router_name.dart';
import 'package:erp_client_1/features/system/auth/presentation/notifier/auth_notifier.dart';
import 'package:erp_client_1/features/system/home/presentation/ui/widget/tree_menu_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

final closeMenuProvider = StateProvider<bool>((ref) {
  return false;
});

class ShellWidget extends ConsumerWidget {
  final Widget child;

  const ShellWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final closeMenu = ref.watch(closeMenuProvider);
    return Scaffold(
      headers: [
        OutlinedContainer(
          borderColor: AppColor.border,
          borderRadius: BorderRadius.circular(0),
          backgroundColor: Colors.gray.shade200,
          child: AppBar(
            height: 30,
            padding: EdgeInsets.all(0),

            // backgroundColor: Colors.gray.shade200,
            backgroundColor: Colors.cyan.shade800,
            leading: [
              IconButton.text(
                icon: Icon(PhosphorIcons.list,color: Colors.white,),
                onPressed: () {
                  ref.read(closeMenuProvider.notifier).state = !closeMenu;
                },
              ),
              TextButton(
                child: Text("Home", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  context.goNamed(RouterName.home);
                },
              ),
              TextButton(
                child: Text("Đăng xuất", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).logout();
                },
              ),
            ],
            trailing: [
              Text(
                'Người dùng: ${ref.read(authNotifierProvider).value?.info?.fullName}',
                style: TextStyle(color: Colors.white),
              ).medium(),
              Gap(10),
            ],
          ),
        ),
      ],
      child: Row(
        children: [
          Visibility(
            visible: !closeMenu,
            maintainState: true,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.zero,
                color: Colors.gray.shade200,
                border: Border(right: BorderSide(color: AppColor.border)),
              ),
              width: 250,
              child: TreeMenuWidget(),
            ),
          ),

          Expanded(child: child),
        ],
      ),
    );
  }
}

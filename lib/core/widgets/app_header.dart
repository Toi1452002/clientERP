import 'package:erp_client_1/core/widgets/app_container_border.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';

import '../constain/app_color.dart';


class AppHeader extends StatelessWidget {
  final String title;
  final List<Widget> trailing;
  const AppHeader({super.key, required this.title, this.trailing = const []});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColor.border)),
      ),
      child: AppBar(
        // height: 20,
        backgroundColor: Colors.gray.shade200,
        padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
        title: Text(title),
        trailing: trailing,
      ),
    );
  }
}

class AppFooter extends StatelessWidget {
  const AppFooter({super.key, this.leading = const []});
  final List<Widget> leading;

  @override
  Widget build(BuildContext context) {
    return  AppContainerBorder(
      child: AppBar(
        backgroundColor: AppColor.background,
        height: 20,
        leading: leading,
      ),
    );
  }
}


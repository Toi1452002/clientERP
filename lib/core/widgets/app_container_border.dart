import 'package:flutter/material.dart';

import '../constain/app_color.dart';

class AppContainerBorder extends StatelessWidget {
  const AppContainerBorder({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.border300)
      ),
      child: child,
    );
  }
}

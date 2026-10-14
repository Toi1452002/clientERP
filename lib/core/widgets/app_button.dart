import 'dart:math';

import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({super.key, this.onPressed, this.enabled = true, required this.text});

  final void Function()? onPressed;
  final bool enabled;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      size: ButtonSize.normal,
      // leading: Icon(PhosphorIcons.filePlus),
      enabled: enabled,
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class AppNewButton extends StatelessWidget {
  const AppNewButton({super.key, this.onPressed, this.enabled = true, required this.text});

  final void Function()? onPressed;
  final bool enabled;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      size: ButtonSize.normal,
      // leading: Icon(PhosphorIcons.filePlus,size: 16,weight: 20, color: enabled ? Colors.blue.shade800 : Colors.gray),
      enabled: enabled,
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: enabled ? Colors.blue.shade800 : Colors.gray)),
    );
  }
}

class AppPrintButton extends StatelessWidget {
  const AppPrintButton({super.key, this.onPressed, this.enabled = true});

  final void Function()? onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    // return TextButton(child: Text("Print PDF"),onPressed: onPressed,);
    return OutlineButton(
      // icon: Icon(PhosphorIcons.printer,size: 16, color: enabled? Colors.orange.shade900: Colors.gray),
      enabled: enabled,
      onPressed: onPressed,
      child: Text('In', style: TextStyle(color: enabled ? Colors.orange.shade900 : Colors.gray)),
    );
  }
}

class AppReloadButton extends StatelessWidget {
  const AppReloadButton({super.key, this.onPressed, this.enabled = true});

  final void Function()? onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return IconButton.outline(
      icon: Icon(PhosphorIcons.arrowsClockwise, size: 16),
      enabled: enabled,
      onPressed: onPressed,
      // trailing: Text('Refresh'),
    );
  }
}

class AppDeleteButton extends StatelessWidget {
  const AppDeleteButton({super.key, this.onPressed, this.enabled = true});

  final bool enabled;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      // icon: Icon(PhosphorIcons.trash, size: 16, color: enabled ? Colors.red : Colors.gray),
      onPressed: onPressed,
      enabled: enabled,
      child: Text('Xóa', style: TextStyle(color: enabled ? Colors.red : Colors.gray)),
    );
  }
}

class AppSettingButton extends StatelessWidget {
  const AppSettingButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.outline(
      icon: Icon(PhosphorIcons.gearSix, size: 16),
      onPressed: onPressed,
      // trailing: Text('Xóa'),
    );
  }
}

class AppSaveButton extends StatelessWidget {
  const AppSaveButton({super.key, this.onPressed, this.text = "Lưu", this.enabled = true, this.toolTip = false});

  final String text;
  final void Function()? onPressed;
  final bool enabled;
  final bool toolTip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      tooltip: (BuildContext context) {
        if (toolTip) return OutlinedContainer(child: Text('Ctrl+S'));
        return SizedBox();
      },
      child: PrimaryButton(
        // icon: Icon(
        //   PhosphorIcons.floppyDisk,
        //   color: enabled ? Colors.blue.shade900 : Colors.gray,
        //   weight: 5,
        //   size: 16,
        //   // fontWeight: FontWeight.bold,
        // ),
        onPressed: onPressed,
        enabled: enabled,
        child: Text(text,),
      ),
    );
  }
}

class AppEditButton extends StatelessWidget {
  const AppEditButton({super.key, this.onPressed, this.enabled = true});

  final bool enabled;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      enabled: enabled,
      // icon: Icon(PhosphorIcons.pencilSimple, size: 16, color: enabled ? Colors.green.shade700 : Colors.gray, weight: 5),
      onPressed: onPressed,
      child: Text("Sửa", style: TextStyle(color: enabled ? Colors.green.shade700 : Colors.gray)),
    );
  }
}

class AppAddButton extends StatelessWidget {
  const AppAddButton({super.key, this.onPressed, this.enabled = true});

  final bool enabled;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.outline(
      icon: Icon(PhosphorIcons.plus, size: 16, color: Colors.green, weight: 5, fontWeight: FontWeight.bold),
      onPressed: onPressed,
      enabled: enabled,
      size: ButtonSize(.9),
    );
  }
}

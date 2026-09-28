import 'package:flutter/material.dart' as mt;
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../constain/app_color.dart';

class AppTableCell{
  AppTableCell._();

  static Text textNum(String str) => Text(
    str,
    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
    textAlign: TextAlign.center,
  );

  static Text textRed(String str) => Text(
    str,
    softWrap: false,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.red.shade700),
  );
  static Text textBlue(String? str) => Text(
    str??"",
    softWrap: false,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.blue.shade900),
  );
  static mt.InkWell delete(void Function()? onTap, {bool enabled = true}) => mt.InkWell(
    onTap: enabled ? onTap : null,
    child: Icon(PhosphorIcons.trash, color: enabled ? Colors.red.shade700 : Colors.gray),
  );
  static mt.InkWell edit(void Function()? onTap, {bool enabled = true}) => mt.InkWell(
    onTap: enabled ? onTap : null,
    child: Icon(PhosphorIcons.pencilSimple, color: enabled ? Colors.green.shade700 : Colors.gray),
  );
}
Widget CustomTitle(String text) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.gray.shade100,
      border: Border(right: BorderSide(color: AppColor.border300)),
    ),
    child: Center(child: Text(text, textAlign: TextAlign.center, softWrap: true).medium),
  );
}
// CustomTitle(String s1, String s2) {
//   return Container(
//     alignment: Alignment.center,
//     decoration: BoxDecoration(
//       color: Colors.gray.shade200,
//       border: Border(right: BorderSide(color: Colors.black, width: .5)),
//     ),
//     child: Basic(
//       subtitleAlignment: Alignment.center,
//       titleAlignment: Alignment.center,
//       title: Text('$s1\n$s2', textAlign: TextAlign.center),
//       // subtitle: Text(s2),
//     ),
//   );
// }
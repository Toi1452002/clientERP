import 'package:erp_client_1/core/shortcut/Shortcut_intent.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';



class ShortcutConfig {
  static final shortcut = <ShortcutActivator, Intent>{
    const SingleActivator(LogicalKeyboardKey.keyS, control: true): const SaveIntent(),
    const SingleActivator(LogicalKeyboardKey.keyE, control: true): const EditIntent(),
    const SingleActivator(LogicalKeyboardKey.keyN, control: true): const NewIntent(),
    const SingleActivator(LogicalKeyboardKey.delete, control: true): const DeleteIntent(),
    const SingleActivator(LogicalKeyboardKey.keyN, control: true,shift: true): const ShowPNIntent(),
    const SingleActivator(LogicalKeyboardKey.keyX, control: true,shift: true): const ShowPXIntent(),
    const SingleActivator(LogicalKeyboardKey.keyT, control: true,shift: true): const ShowPTIntent(),
    const SingleActivator(LogicalKeyboardKey.keyC, control: true,shift: true): const ShowPCIntent(),
    const SingleActivator(LogicalKeyboardKey.enter): const SaveAndCloseIntent(),
    const SingleActivator(LogicalKeyboardKey.enter, control: true): const SaveConfirmIntent(),
  };
}
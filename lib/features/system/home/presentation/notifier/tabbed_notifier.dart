import 'package:erp_client_1/core/router/router_name.dart';
import 'package:erp_client_1/features/system/home/presentation/ui/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tabbed_view/tabbed_view.dart';

final tabbedProvider = StateNotifierProvider.autoDispose<TabbedNotifier, TabbedViewController>((ref) {
  return TabbedNotifier();
});

class TabbedNotifier extends StateNotifier<TabbedViewController> {
  TabbedNotifier() : super(TabbedViewController([])) {
    state.addTab(TabData(id: 'Home', text: 'Home', view: HomeScreen(), keepAlive: true));
  }

  // TabbedNotifier(super.state);

  void addTab(String code, String name, Widget child) {
    if (!state.tabs.map((e) => e.id).contains(code)) {
      state.addTab(TabData(id: code, text: name, view: child, keepAlive: true));
      final index = state.tabs.map((e) => e.id).toList().indexWhere((e) => e == code);
      state.selectedIndex = index;
    } else {
      final index = state.tabs.map((e) => e.id).toList().indexWhere((e) => e == code);
      state.selectedIndex = index;
    }
  }
}

import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/features/system/home/presentation/notifier/tabbed_notifier.dart';
import 'package:erp_client_1/features/system/home/presentation/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';
import 'package:tabbed_view/tabbed_view.dart';

class TabbedViewCustom extends ConsumerStatefulWidget {
  const TabbedViewCustom({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState createState() => _TabbedViewCustomState();
}

class _TabbedViewCustomState extends ConsumerState<TabbedViewCustom> {
  // late final TabbedViewController _controller;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _controller = TabbedViewController(
  //     List.generate(
  //       6,
  //           (i) => TabData(
  //         id: i,
  //         text: 'Tab ${i + 1}',
  //         view: Center(child: Text('Content ${i + 1}')),
  //       ),
  //     ),
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tabbedProvider);
    final flutterTheme = ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Theme.of(context).colorScheme.primary,
        // brightness: widget.brightness,
      ),
      useMaterial3: Theme.of(context).useMaterial3,

    );
    final TabbedViewThemeData theme = TabbedViewThemeData.minimalist(
      initialGap: 0,
      tabRadius: 3,
      fontSize: 13,
      gap: 0,
      // borderColor: AppColor.border,
      tabStyleResolver: _TabStyle()

    );
    theme.menu.padding = EdgeInsets.all(0);
    theme.tabsArea.buttonIconSize = 12;
    theme.tabsArea.buttonPadding = EdgeInsets.symmetric(horizontal: 5);
    theme.tabsArea.color = AppColor.border300;

    theme.tab.padding = EdgeInsets.symmetric(horizontal: 5);
    theme.menu.style = MenuStyle(
      elevation: WidgetStatePropertyAll(5),
      padding: WidgetStatePropertyAll(EdgeInsets.zero),
      shadowColor: WidgetStatePropertyAll(Colors.black),
    );



    theme.menu.menuItemStyle = ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.white),
      padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
        elevation: WidgetStatePropertyAll(0),
      textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 13))
    );


    return Theme(
      data: flutterTheme,
      child: Material(
        color: Colors.white,
        child: TabbedViewTheme(
          data: theme,
          child: TabbedView(
            viewBuilder: (context, tab) {
              return tab.view??HomeScreen();
            },

            controller: state,
          ),
        ),
      ),
    );
  }
}
class _TabStyle extends MinimalistTabStyleResolver {
  @override
  Color? backgroundColor(TabStyleContext context) {
    switch (context.status) {
      case TabStatus.selected:
        return Colors.cyan.shade800;
      case TabStatus.hovered:
        return Colors.grey.shade100;
      case TabStatus.unselected:
        return Colors.grey.shade300;
    }
    return null;
  }
}
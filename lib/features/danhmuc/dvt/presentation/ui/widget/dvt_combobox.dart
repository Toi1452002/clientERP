import 'dart:math';

import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/features/danhmuc/dvt/presentation/dialog/dvt_dialog.dart';
import 'package:erp_client_1/features/danhmuc/dvt/presentation/notifier/dvt_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../../../../../../core/widgets/app_combobox.dart';

class DvtCombobox extends ConsumerWidget {
  final String? selected;
  final void Function(dynamic)? onChanged;
  final bool noBorder;
  final bool enabled;
  final bool showAdd;
  final void Function()? onTap;

  const DvtCombobox({
    super.key,
    this.onChanged,
    this.selected,
    this.noBorder = false,
    this.enabled = true,
    this.showAdd = false, this.onTap
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dvtProvider);
    return state.when(
      data: (value) {
        return AppCombobox(
          onTap: onTap,
          noSearch: false,
          noBorder: noBorder,
          enabled: enabled,
          onAdd: !showAdd
              ? null
              : () {
                  showAppDialog(context, child: DvtDialog());
                },
          value: selected,
          items: value.map((e) => ComboboxItem(value: e.dvt, text: [e.dvt])).toList(),
          onChanged: onChanged,
        );
      },
      error: (e, s) => Text(e.toString()),
      loading: () => LinearProgressIndicator(),
    );
  }
}

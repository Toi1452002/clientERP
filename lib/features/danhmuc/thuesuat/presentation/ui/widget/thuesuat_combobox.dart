import 'dart:math';

import 'package:erp_client_1/core/widgets/app_combobox.dart';
import 'package:erp_client_1/features/danhmuc/thuesuat/presentation/ui/state/thuesuat_lookup_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ThueSuatCombobox extends ConsumerWidget {
  const ThueSuatCombobox({super.key, this.enabled = true, this.selected, this.onChanged});

  final int? selected;
  final void Function(dynamic)? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(thueSuatLookupProvider);
    return state.when(
      data: (val) {
        return AppCombobox(
          enabledClear: false,
          onChanged: onChanged,
          enabled: enabled,
          value: selected,
          items: val.map((e) => ComboboxItem(value: e.value, text: [e.moTa])).toList(),
        );
      },
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => LinearProgressIndicator(),
    );
  }
}

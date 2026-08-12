import 'dart:math';

import 'package:erp_client_1/core/widgets/app_combobox.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/ui/state/nhanvien_lookup_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NhanVienCombobox extends ConsumerWidget {
  const NhanVienCombobox({super.key, this.selected, this.onChanged, this.enabled = true});
  final String? selected;
  final void Function(dynamic)? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(nhanVienLookupProvider);
    return state.when(
      skipLoadingOnRefresh: false,
      data: (val) {
        return AppCombobox(
          noSearch: false,
          enabled: enabled,
          onChanged: onChanged,
          value: selected,
          menuWidth: 300,
          columnWidth: [50, 250],
          items: val.map((e) => ComboboxItem(value: e.maNV, text: [e.maNV, e.tenNV])).toList(),
        );
      },
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => LinearProgressIndicator(),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../../core/widgets/app_combobox.dart';
import '../../notifier/hanghoa_edit_notifier.dart';

class LoaiHangCombobox extends ConsumerWidget {
  final int? selected;
  final void Function(dynamic)? onChanged;
  const LoaiHangCombobox({super.key, this.selected, this.onChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loaiHangProvider);
    return state.when(
      data: (value) {
        return AppCombobox(
          enabledClear: false,
          items: value.map((e) => ComboboxItem(value: e.id, text: [e.loaiHang])).toList(),
          onChanged: onChanged,
          value: selected,
        );
      },
      error: (e, s) => Text(e.toString()),
      loading: () => LinearProgressIndicator(),
    );
  }
}

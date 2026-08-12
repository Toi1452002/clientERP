import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/widgets/widget.dart';
import '../../../data/model/khach_lookup_model.dart';
import '../state/khach_lookup_state.dart';

class NhaCungCombobx extends ConsumerWidget {
  final String? selected;
  final void Function(dynamic)? onChanged;
  final bool enabled;
  const NhaCungCombobx({super.key, this.selected, this.onChanged, this.enabled=true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(khachLookupProvider(LoaiKH.NhaCung));
    return state.when(
      skipLoadingOnRefresh: false,
      data: (value) {
        return AppCombobox(
          noSearch: false,
          enabled: enabled,
          onChanged: onChanged,
          value: selected,
          menuWidth: 300,
          columnWidth: [50, 250],
          items: value.map((e) => ComboboxItem(value: e.maKH, text: [e.maKH, e.tenKH])).toList(),
        );
      },
      error: (e, s) => Text(e.toString()),
      loading: () => LinearProgressIndicator(),
    );
  }
}

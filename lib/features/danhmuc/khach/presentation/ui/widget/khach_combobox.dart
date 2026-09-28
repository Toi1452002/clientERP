import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/widgets/widget.dart';
import '../../../data/model/khach_lookup_model.dart';
import '../../dialog/khach_form_dialog.dart';
import '../state/khach_lookup_state.dart';

class KhachCombobox extends ConsumerWidget {
  final String? selected;
  final void Function(dynamic)? onChanged;
  final bool enabled;
  final bool clear;
  final bool showAdd;
  const KhachCombobox({super.key, this.selected, this.onChanged, this.enabled=true, this.clear = true, this.showAdd = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(khachLookupProvider(LoaiKH.Khach));
    return state.when(
      skipLoadingOnRefresh: false,
      data: (value) {
        return AppCombobox(
          noSearch: false,
          onAdd:!showAdd?null: (){
            showAppDialog(context, child: KhachFormDialog());
          },
          onChanged: onChanged,
          enabled: enabled,
          value: selected,
          enabledClear: clear,
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

import 'package:erp_client_1/core/widgets/app_combobox.dart';
import 'package:erp_client_1/features/ketchuyen/presentation/ui/state/buttoan_lookup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButToanCombobox extends ConsumerWidget {
  const ButToanCombobox({super.key, this.selected, this.onChanged, this.isInTable = false});
  final bool isInTable;
  final String? selected;
  final void Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(butToanLookupProvider);
    return state.when(
      data: (val) {
        if(isInTable){
          return AppCombobox(
            enabledClear: false,
            columnWidth: [50,300],
            menuWidth: 350,
            noBorder: true,

            value: selected,
            onChanged: onChanged,
            items: val.map((e) => ComboboxItem(value: e.ma, text: [e.ma,e.butToan])).toList(),
          );
        }
        return AppCombobox(
          enabledClear: false,
          value: selected,
          onChanged: onChanged,
          items: val.map((e) => ComboboxItem(value: "${e.ma}-${e.butToan}", text: ["${e.ma}-${e.butToan}"])).toList(),
        );
      },
      error: (e, s) => Text(e.toString()),
      loading: () => LinearProgressIndicator(),
    );
  }
}
